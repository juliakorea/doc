using Base.Test

function diff_head(codex_path, src_path)
  print("$codex_path: ")
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
  original = open(readall, codex_path)
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
push!(LOAD_PATH, "scripts")
using settings
for item in doc_items
  exit_code |= diff_head(item.codex_path, item.src_path)
end
exit(exit_code)
