module ProjectTests

using Test
using GCP
using ..GCPTests

@testset "Project" begin

  @test begin
    proj = GCP.Project(GCPTests.CredFilename, ["cloud-platform"])
    proj != nothing
  end

end

end # module ProjectTests
