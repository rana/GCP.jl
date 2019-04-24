module GCP
include("util.jl")
include("credential.jl")
include("session.jl")
include("bigquery.jl")
using .Bigquery
mutable struct Project
    id::String
    credential::Credential
    session::Session
    authorize
    bigquery::Bigquery.Service
    function Project(credential, scopes::AbstractVector{<:AbstractString})
        p = new()
        begin
            if credential isa String && isfile(credential)
                p.credential = Credential(credential)
            else
                p.credential = credential
            end
            p.session = Session(p.credential, scopes)
            p.id = (p.credential).project_id
            p.authorize = function authorize(; kws...)
                    auth = GCP.authorize(p.session; kws...)
                    headers = Dict{String, String}("Authorization" => "$(auth[:token_type]) $(auth[:access_token])")
                    headers
                end
        end
        p.bigquery = Bigquery.Service(p)
        p
    end
end
end