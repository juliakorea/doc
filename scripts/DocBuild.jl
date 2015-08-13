push!(LOAD_PATH, "scripts")

using Setting
using DocUtil

build_dir = is_scripts ? "../build" : "build"

mkdir_if_not_exist(path) = !isdir(path) && begin
  println("mkdir $path")
  mkdir(path)
end
mkdir_if_not_exist(normpath(build_dir, "manual"))
mkdir_if_not_exist(normpath(build_dir, "phdthesis"))

for file in juliadoc.files
  src_path = get_src_path(juliadoc.name, file)
  build_path = normpath(build_dir, file)
  gen_rst(src_path, build_path)
end
for file in phdthesis.files
  src_path = get_src_path(phdthesis.name, file)
  build_path = normpath(build_dir, phdthesis.name, file)
  gen_rst(src_path, build_path)
end
