using StaticArrays, Test, Random, LinearAlgebra
using InteractiveUtils

# We generate a lot of matrices using rand(), but unit tests should be
# deterministic. Therefore seed the RNG here (and further down, to avoid test
# file order dependence)
Random.seed!(42)
include("testutil.jl")

# Hook into Pkg.test so that tests from a single file can be run.  For example,
# to run only the MVector and SVector tests, use:
#
#   Pkg.test("StaticArrays", test_args=["MVector", "SVector"])
#
enabled_tests = lowercase.(ARGS)
function addtests(fname)
    key = lowercase(splitext(fname)[1])
    if isempty(enabled_tests) || key in enabled_tests
        Random.seed!(42)
        include(fname)
    end
end

TEST_GROUP = get(ENV, "STATICARRAYS_TEST_GROUP", "all")

if TEST_GROUP ∈ ["group-A", "group-B"]
    println("Using test group: ", TEST_GROUP)
end

if TEST_GROUP ∈ ["", "all", "group-A"]
    addtests("SVector.jl")
    addtests("MVector.jl")
    addtests("SMatrix.jl")
    addtests("MMatrix.jl")
    addtests("SArray.jl")
    addtests("MArray.jl")
    addtests("FieldVector.jl")
    addtests("FieldMatrix.jl")
    addtests("Scalar.jl")
    addtests("SUnitRange.jl")
    addtests("SizedArray.jl")
    addtests("SDiagonal.jl")
    addtests("SHermitianCompact.jl")
    if VERSION >= v"1.8.0-beta1"
        addtests("empty_array_syntax.jl")
    end

    addtests("ambiguities.jl")
    addtests("unbound_args.jl")
    addtests("custom_types.jl")
    addtests("convert.jl")
    addtests("core.jl")
    addtests("abstractarray.jl")
    addtests("indexing.jl")
    addtests("initializers.jl")
    addtests("mapreduce.jl")
    addtests("sort.jl")
    addtests("accumulate.jl")
    addtests("arraymath.jl")
    addtests("broadcast.jl")
    addtests("linalg.jl")
    addtests("matrix_multiply.jl")
    addtests("matrix_multiply_add.jl")
    addtests("triangular.jl")
    addtests("det.jl")
    addtests("inv.jl")
    addtests("pinv.jl")
    addtests("solve.jl")
end

if TEST_GROUP ∈ ["", "all", "group-B"]
    addtests("eigen.jl")
    addtests("expm.jl")
    addtests("sqrtm.jl")
    addtests("lyap.jl")
    addtests("lu.jl")
    addtests("qr.jl")
    addtests("chol.jl") # hermitian_type(::Type{Any}) for block algorithm
    addtests("deque.jl")
    addtests("flatten.jl")
    addtests("io.jl")
    addtests("svd.jl")
    addtests("unitful.jl")
end
