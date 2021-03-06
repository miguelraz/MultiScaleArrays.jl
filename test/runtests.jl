using MultiScaleArrays, OrdinaryDiffEq, DiffEqBase, StochasticDiffEq
using Base.Test

@time @testset "Bisect Search Tests" begin include("bisect_search_tests.jl") end
@time @testset "Indexing and Creation Tests" begin include("indexing_and_creation_tests.jl") end
@time @testset "Get Indices Tests" begin include("get_indices.jl") end
@time @testset "Dynamic DiffEq Tests" begin include("dynamic_diffeq.jl") end
