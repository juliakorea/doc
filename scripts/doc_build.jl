push!(LOAD_PATH, "scripts")

include("translate.jl")


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

do_doc_build()
