function gen_rst(path)
  outfile = "$path"
  out = open(outfile, "w")
  txt = open(readall, "$path.txt")
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
end

for path in ["manual/introduction.rst"]
  gen_rst(path)
end
