using Base.Test

function diff_manual(src, target, path)
  src_path = normpath(relpath(src), "$path.txt")
  target_dir = relpath(target)
  if nothing == Base.find_in_path(src_path)
    src_path = normpath(relpath("../$src"), "$path.txt")
    target_dir = relpath("../$target")
  end

  print("$src_path: ")
  txt = open(readall, src_path)
  lines = String[]
  for line in split(txt, "\n")
    len = length(line)
    if len > 1
      if "++" == line[1:2]
      else
        push!(lines, string(line[min(4,len+1):end], "\n"))
      end
    end
  end

  exit_code = 0
  target_path = normpath(target_dir, path)
  original = open(readall, target_path)
  if original == join(lines)
    print_with_color(:green, "ok")
  else
    print_with_color(:red, "needs an update")
    exit_code = 1
  end
  println()
  exit_code
end

exit_code = 0
for path in ["index.rst", "manual/introduction.rst"]
  exit_code |= diff_manual("src", "julia/doc", path)
end
exit(exit_code)
