module CredentialTests

using Test
using GCP
using ..GCPTests

@testset "Credential" begin

  @test begin
    cred = GCP.Credential(GCPTests.CredFilename)
    cred != nothing
  end

end

end # module CredentialTests