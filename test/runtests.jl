using Dates
using Random
using Test
using JessamineCLI

include("Aqua.jl")

Random.seed!(0x30c4070874d73da0)

@testset "JessamineCLI.jl" begin
    include("TestRegression.jl")
end
