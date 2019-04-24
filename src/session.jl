import JSON
import MbedTLS
using Dates, Base64
using HTTP, HTTP.Messages

const API_ROOT = "https://www.googleapis.com"
const SCOPE_ROOT = "$API_ROOT/auth"
const AUD_ROOT = "$API_ROOT/oauth2/v4/token"

"""
    isurl(path)

Return true if `path` is a URL and false a path fragment.
"""
isurl(path::AbstractString) = occursin(r"^https?://", path)


"""
    SHA256withRSA(message, key)

Sign message using private key with RSASSA-PKCS1-V1_5-SIGN algorithm.
"""
SHA256withRSA(message, key::MbedTLS.PKContext) = MbedTLS.sign(key, MbedTLS.MD_SHA256,
    MbedTLS.digest(MbedTLS.MD_SHA256, message), MbedTLS.MersenneTwister(0)
)

"""
Session(...)

OAuth 2.0 session for Google using provided credential.

Caches authorisation tokens up to expiry.

```julia
sess = Session(Credential(expanduser("~/auth.json")), ["devstorage.full_control"])
```
"""
mutable struct Session{T <: Credential}
    credential::T
    scopes::Vector{String}
    authorization::Dict{Symbol, Any}
    expiry::DateTime
    """
        Session(credential, scopes)

    Set up session with credential and OAuth scopes.
    """
    function Session(credential::T, scopes::AbstractVector{<: AbstractString}) where {T <: Credential}
        scopes = [isurl(scope) ? scope : "$SCOPE_ROOT/$scope" for scope in scopes]
        new{T}(credential, scopes, Dict{String, String}(), DateTime(1))
    end
end

function Session(credential::Union{AbstractString, Nothing}, scopes::AbstractVector{<: AbstractString}=String[])
    if credential === nothing
        credential = ""
    end
    if isfile(credential)
        credential = Credential(credential)
    end
    Session(credential, scopes)
end

function Session(scopes::AbstractVector{<: AbstractString})
    Session(get(ENV, "GOOGLE_APPLICATION_CREDENTIALS", ""), scopes)
end

function Base.print(io::IO, x::Session)
    println(io, "scopes: $(x.scopes)")
    println(io, "authorization: $(x.authorization)")
    println(io, "expiry: $(x.expiry)")
end
Base.show(io::IO, x::Session) = print(io, x)

"""
    unixseconds(x)

Convert date-time into unix seconds.
"""
unixseconds(x::DateTime) = trunc(Int, datetime2unix(x))

"""
    JWTHeader

JSON Web Token header.
"""
struct JWTHeader
    algorithm::String
end
function Base.string(x::JWTHeader)
    base64encode(JSON.json(Dict(:alg => x.algorithm, :typ => "JWT")))
end
Base.print(io::IO, x::JWTHeader) = print(io, string(x))

"""
    JWTClaimSet

JSON Web Token claim-set.
"""
struct JWTClaimSet
    issuer::String
    scopes::Vector{String}
    assertion::DateTime
    expiry::DateTime
    function JWTClaimSet(issuer::AbstractString, scopes::AbstractVector{<: AbstractString}, assertion::DateTime=now(UTC), expiry::DateTime=now(UTC) + Hour(1))
        new(issuer, scopes, assertion, expiry)
    end
end
function Base.string(x::JWTClaimSet)
    base64encode(JSON.json(Dict(
        :iss => x.issuer,
        :scope => join(x.scopes, " "),
        :aud => AUD_ROOT,
        :iat => unixseconds(x.assertion),
        :exp => unixseconds(x.expiry)
    )))
end
Base.print(io::IO, x::JWTClaimSet) = print(io, string(x))

"""
    JWS(credential, claimset)

Construct the Base64-encoded JSON Web Signature based on the JWT header, claimset
and signed using the private key provided in the Google JSON service-account key.
"""
function JWS(credential::Credential, claimset::JWTClaimSet, header::JWTHeader=JWTHeader("RS256"))
    payload = "$header.$claimset"
    signature = base64encode(SHA256withRSA(payload, credential.private_key))
    "$payload.$signature"
end

function token(credential::Credential, scopes::AbstractVector{<: AbstractString}; kws...)
    # construct claim-set from service account email and requested scopes
    claimset = JWTClaimSet(credential.client_email, scopes)
    data = HTTP.URIs.escapeuri(Dict{Symbol, String}(
        :grant_type => "urn:ietf:params:oauth:grant-type:jwt-bearer",
        :assertion => JWS(credential, claimset)
    ))
    headers = Dict{String, String}("Content-Type" => "application/x-www-form-urlencoded")
    res = HTTP.post("$AUD_ROOT", headers, data; kws...)
    if res.status != 200
        throw("Unable to obtain authorization: $(read(res, String))")
    end
    authorization = JSON.parse(payload(res, String); dicttype=Dict{Symbol, Any})
    authorization, claimset.assertion
end

"""
    authorize(session; cache=true)

Get OAuth 2.0 authorisation token from Google.

If `cache` set to `true`, get a new token only if the existing token has expired.
"""
function authorize(session::Session; cache::Bool=true, kws...)
    # don't get a new token if a non-expired one exists
    if cache && (session.expiry >= now(UTC)) && !isempty(session.authorization)
        return session.authorization
    end

    authorization, assertion = try token(session.credential, session.scopes; kws...) catch e
        session.expiry = DateTime(1)
        empty!(session.authorization)
        rethrow(e)
    end

    # cache authorization if required
    if cache
        session.expiry = assertion + Second(authorization[:expires_in] - 30)
        session.authorization = authorization
    else
        session.expiry = DateTime(1)
        empty!(session.authorization)
    end
    authorization
end