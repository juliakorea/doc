using Base.Test

function diff_manual(path)
  target_dir = relpath(".")
  if nothing == Base.find_in_path(normpath(target_dir, "$path.txt"))
    target_dir = relpath("..")
  end
  path_txt = normpath(target_dir, "$path.txt")
  translated = open(readall, path_txt)
  lines = String[]
  for line in split(translated, "\n")
    len = length(line)
    if len > 1
      if "++" == line[1:2]
      else
        push!(lines, string(line[min(4,len+1):end], "\n"))
      end
    end
  end
  original = open(readall, normpath(target_dir, "julia/doc/$path"))
  print("$path_txt: ")
  if original == join(lines)
    print_with_color(:green, "ok")
  else
    print_with_color(:red, "needs an update")
  end
  println()
end

for path in ["manual/introduction.rst"]
  diff_manual(path)
end
