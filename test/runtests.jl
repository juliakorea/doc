using Base.Test

push!(LOAD_PATH, "scripts")

using Setting

path = get_src_path("julia/doc", "manual/getting-started.rst")
@test "src/julia/doc/manual/getting-started.rst.txt" == path


using DocUtil

codex_path = "codex/julia/doc/manual/getting-started.rst"
src_path = "src/julia/doc/manual/getting-started.rst.txt"
@test 0 == diff_head(codex_path, src_path)
build_path = "test/temp"
@test nothing == gen_rst(src_path, build_path)
rm(build_path)
