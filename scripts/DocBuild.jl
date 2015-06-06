function gen_rst(src_path, build_path)
  out = open(build_path, "w")

  txt = open(readall, src_path)
  for line in split(txt, "\n")
    len = length(line)
    if len > 1
      if "--" == line[1:2]
      else
        println(out, line[min(4,len+1):end])
      end
    end
  end
  close(out)
  println("generated $build_path")
end

push!(LOAD_PATH, "scripts")
using settings

build_dir = is_scripts ? "../build" : "build"
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
