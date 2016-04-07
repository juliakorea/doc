include("settings.jl")

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

function do_diff_head()
    exit_code = 0
    for item in fileitems_from_codex()
      if item.translated
        src_path = normpath(docsetting[:src], item.path)".txt"
        codex_path = normpath(docsetting[:codex], item.path)
        exit_code |= diff_head(codex_path, src_path)
      end
    end
    exit_code
end



function do_doc_build()
    build_dir = docsetting[:build]
    codex_dir = docsetting[:codex]
    src_dir = docsetting[:src]
    julia_doc = "julia/doc/"
    
    mkdir_if_not_exist(normpath(build_dir, "manual"))
    mkdir_if_not_exist(normpath(build_dir, "stdlib"))
    mkdir_if_not_exist(normpath(build_dir, "devdocs"))
    mkdir_if_not_exist(normpath(build_dir, "phdthesis"))
    mkdir_if_not_exist(normpath(build_dir, "_build/html/_static"))
    
    translated_files = AbstractString[]
    for item in fileitems_from_codex()
      path = startswith(item.path, julia_doc) ? item.path[length(julia_doc)+1:end] : item.path
      if item.translated
        src_path = normpath(src_dir, item.path)".txt"
        gen_rst(src_path, normpath(build_dir, path), true)
        push!(translated_files, path[1:end-length(".rst")])
      else
        codex_path = normpath(codex_dir, item.path)
        gen_rst(codex_path, normpath(build_dir, path), false)
      end
    end
    
    gen_blame(translated_files, normpath(build_dir, "_build/html/_static/blame.js"))
end
