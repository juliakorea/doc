push!(LOAD_PATH, "scripts")

include("translate.jl")

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

exit(do_diff_head())
