module Setting

export file_items
export build_dir, src_dir, codex_dir

type FileItem
  path::AbstractString
  translated::Bool
end

is_scripts = "scripts" == basename(pwd())
build_dir = string(is_scripts ? "../" : "", "build")
src_dir = string(is_scripts ? "../" : "", "src")
codex_dir = string(is_scripts ? "../" : "", "codex")

function walk_dir(func, root)
  walk_dir(func, root, root)
end

function walk_dir(func, root, path)
  for name in readdir(path)
    subpath = joinpath(path, name)
    if isdir(subpath)
      walk_dir(func, root, subpath)
    else
      func(name, subpath[length(root)+2:end])
    end
  end
end

function fileitems_from_codex()
  items = FileItem[]
  walk_dir(codex_dir) do name, path
    src_path = joinpath(src_dir, path)".txt"
    item = FileItem(path, isfile(src_path))
    push!(items, item)
  end
  return items
end

file_items = fileitems_from_codex()

end
