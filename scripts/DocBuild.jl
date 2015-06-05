function gen_rst(src, target, path)
  src_dir = relpath(src)
  src_path = normpath(src_dir, "$path.txt")
  target_dir = relpath(target)
  if nothing == Base.find_in_path(src_path)
    src_dir =  relpath("../$src")
    src_path = normpath(src_dir, "$path.txt")
    target_dir = relpath("../$target")
  end

  target_path = normpath(target_dir, path)
  out = open(target_path, "w")

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
  println("generated $target_path")
end

push!(LOAD_PATH, "scripts")
using SrcPath
for path in SRC_PATH
  gen_rst("src", "build", path)
end
