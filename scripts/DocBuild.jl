function gen_rst(path)
  target_dir = relpath(".")
  if nothing == Base.find_in_path(normpath(target_dir, "$path.txt"))
    target_dir = relpath("..")
  end
  path_txt = normpath(target_dir, "$path.txt")

  out_path = normpath(target_dir, path)
  out = open(out_path, "w")

  txt = open(readall, path_txt)
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
  println("generated $out_path")
end

for path in ["manual/introduction.rst"]
  gen_rst(path)
end
