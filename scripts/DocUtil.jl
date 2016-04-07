module DocUtil

export diff_head, gen_rst, gen_blame, mkdir_if_not_exist

if VERSION.minor < 5
  readstring = readall
end

function diff_head(codex_path, src_path)
  print("$codex_path: ")
  txt = open(readstring, src_path)
  lines = AbstractString[]
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
  original = open(readstring, codex_path)
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


function gen_rst(src_path, build_path, translated)
  #println("gen_rst: ", src_path, " ", build_path, " ", translated)
  out = open(build_path, "w")
  txt = open(readstring, src_path)

  if translated
    for line in split(txt, "\n")
      len = length(line)
      if len > 1
        if "--" == line[1:2]
        else
          println(out, line[min(4,len+1):end])
        end
      end
    end
  else
    println(out, txt)
  end
  close(out)

  if translated
    println("generated $build_path")
  else
    # println("copied    $build_path")
  end
end

function gen_blame(translated_files, blame_path)
  list = join(map(repr, translated_files), ", ")
  blame = """
function blame(pagename) {
  var translated = [$list];
  if (-1 == \$.inArray(pagename, translated)) {
    window.open("https://github.com/JuliaLang/julia/blame/master/doc/" + pagename + ".rst", "blame");
  } else {
    window.open("https://github.com/juliakorea/doc/blame/master/src/julia/doc/" + pagename + ".rst.txt", "blame");
  }
}
"""
  out = open(blame_path, "w")
  println(out, blame)
  close(out)
  println("generated $blame_path")
end


mkdir_if_not_exist(path) = !isdir(path) && begin
  println("mkdir $path")
  mkpath(path)
end

end
