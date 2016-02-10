push!(LOAD_PATH, "scripts")

using Setting
using DocUtil

exit_code = 0
for item in file_items
  if item.translated
    src_path = normpath(src_dir, item.path)".txt"
    codex_path = normpath(codex_dir, item.path)
    exit_code |= diff_head(codex_path, src_path)
  end
end
exit(exit_code)
