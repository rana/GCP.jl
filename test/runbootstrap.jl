include("../src/bootstrap.jl")

using .Bootstrap.Emit

# add other gcp Apis here (if needed)
Emit.getEmit(:bigquery)