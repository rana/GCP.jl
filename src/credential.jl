using MbedTLS
using HTTP.URIs
using JSON
# export Credential
struct Credential
  account_type::String
  project_id::String
  private_key_id::String
  private_key::MbedTLS.PKContext
  client_email::String
  client_id::String
  auth_uri::URI
  token_uri::URI
  auth_provider_x509_cert_url::URI
  client_x509_cert_url::URI
  function Credential(
    account_type::AbstractString,
    project_id::AbstractString,
    private_key_id::AbstractString,
    private_key::AbstractString,
    client_email::AbstractString,
    client_id::AbstractString,
    auth_uri::AbstractString,
    token_uri::AbstractString,
    auth_provider_x509_cert_url::AbstractString,
    client_x509_cert_url::AbstractString)
      ctx = MbedTLS.PKContext()
      MbedTLS.parse_key!(ctx, private_key)
      new(
          account_type, project_id, private_key_id, ctx, client_email, client_id,
          URI(auth_uri), URI(token_uri), URI(auth_provider_x509_cert_url), URI(client_x509_cert_url)
      )
  end
end

"""
    Credential(data::Dict{Symbol, String})

Initialise credentials from dictionary containing values.
"""
function Credential(data::AbstractDict{Symbol, <: AbstractString})
    fields = fieldnames(Credential)
    fields = [fields...,]
    fields[findfirst(x->x==:account_type, fields)] = :type  # type is a keyword!
    missing = setdiff(fields, keys(data))
    if !isempty(missing)
        @info missing
        throw("Missing fields in key: ", join(missing, ", "))
    end
    Credential((data[field] for field in fields)...)
end
function Credential(data::AbstractDict{Symbol, <: Any})
    fields = fieldnames(Credential)
    fields = [fields...,]
    fields[findfirst(x->x==:account_type, fields)] = :type  # type is a keyword!
    missing = setdiff(fields, keys(data))
    if !isempty(missing)
        @info missing
        throw("Missing fields in key: ", join(missing, ", "))
    end
    Credential((data[field] for field in fields)...)
end

"""
    Credential(filename)

Load credentials from a JSON file.
"""
Credential(filename::AbstractString) = Credential(JSON.parsefile(filename; dicttype=Dict{Symbol, String}))
Credential(io::IO) = Credential(JSON.parse(io; dicttype=Dict{Symbol, String}))

Base.convert(::Type{Credential}, x::AbstractString) = Credential(x)

function Base.print(io::IO, x::Credential)
    fields = [:project_id, :client_email]
    print(io, join(("$field: $(getfield(x, field))" for field in fields), "\n"))
end
Base.show(io::IO, x::Credential) = print(io, x)