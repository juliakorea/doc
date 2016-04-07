type FileItem
  path::AbstractString
  translated::Bool
end

function update_codex_if_possible()
    juliadoc = "../julia/doc"
    if isdir(juliadoc)
       # println("update_codex_if_possible $juliadoc")
       run(`cp $juliadoc/index.rst codex/julia/doc/`)
       for dir in ["manual" "devdocs" "stdlib"]
         run(`cp -r $juliadoc/$dir codex/julia/doc/`)
       end
    end
end

docsetting = Dict(
    :src => "src",
    :codex => "codex", # juliadoc_or_codex(),
    :build => "build",
)

function walk_dir(func, root)
    walk_dir(func, root, root)
end

function walk_dir(func, root, path)
  for name in readdir(path)
    subpath = joinpath(path, name)
    if isdir(subpath)
      walk_dir(func, root, subpath)
    else
      for ext in [".rst", ".tex"]
        if endswith(name, ext)
          func(name, subpath[length(root)+2:end])
        end
      end
    end
  end
end

function fileitems_from_codex()
  items = FileItem[]
  walk_dir(docsetting[:codex]) do name, path
    src_path = joinpath(docsetting[:src], path)".txt"
    translated = isfile(src_path)
    item = FileItem(path, translated)
    push!(items, item)
  end
  return items
end

update_codex_if_possible()
file_items = fileitems_from_codex()
