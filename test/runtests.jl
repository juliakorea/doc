using Base.Test

push!(LOAD_PATH, "../scripts")
push!(LOAD_PATH, "scripts")

using Setting
using DocUtil

codex_path = "codex/julia/doc/manual/getting-started.rst"
src_path = "src/julia/doc/manual/getting-started.rst.txt"
@test 0 == diff_head(codex_path, src_path)
build_path = "test/temp"
@test nothing == gen_rst(src_path, build_path, false)
rm(build_path)

directory = "test/dir"
mkdir_if_not_exist(directory)

codex_path = "test/outdated_example.rst"
src_path = "test/outdated_example.rst.txt"
@test 1 == diff_head(codex_path, src_path)
