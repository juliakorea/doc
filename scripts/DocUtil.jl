module DocUtil

export diff_head, gen_rst, mkdir_if_not_exist


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
    print_with_color(:red, "needs an update\n")
    (path, fd::IOStream) = Base.mktemp()
    write(fd, join(lines))
    close(fd)
    try
      Base.run(`git diff $path $codex_path`)
    end
    Base.rm(path)
    exit_code = 1
  end
  println()
  exit_code
end


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


mkdir_if_not_exist(path) = !isdir(path) && begin
  println("mkdir $path")
  mkdir(path)
end

end
