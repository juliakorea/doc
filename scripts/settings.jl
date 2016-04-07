type FileItem
    path::AbstractString
    translated::Bool
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
