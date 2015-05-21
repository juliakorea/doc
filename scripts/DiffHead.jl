using Base.Test

function diff_manual(path)
  translated = open(readall, "$path.txt")
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
  original = open(readall, "julia/doc/$path")
  @test original == join(lines) 
end

for path in ["manual/introduction.rst"]
  diff_manual(path)
end
