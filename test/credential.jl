module CredentialTests

using Test
using GCP
using JSON
using ..GCPTests

@testset "Credential" begin

  @test begin
    cred = GCP.Credential(GCPTests.CredFilename)
    cred != nothing
  end
  @test begin
    j = JSON.parsefile(GCPTests.CredFilename; dicttype=Dict{Symbol, Any})
    cred = GCP.Credential(j)
    cred != nothing
  end

end

end # module CredentialTests