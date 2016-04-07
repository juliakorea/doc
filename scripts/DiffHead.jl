push!(LOAD_PATH, "scripts")

include("translate.jl")

exit(do_diff_head())
