module SessionTests

using Test
using GCP
using ..GCPTests

@testset "Session" begin

  @test begin
    sess = GCP.Session(GCPTests.CredFilename, ["cloud-platform"])
    sess != nothing
  end

end

end # module SessionTests