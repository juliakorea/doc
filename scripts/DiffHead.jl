push!(LOAD_PATH, "scripts")

using Setting
using DocUtil

exit_code = 0
for item in doc_items
  exit_code |= diff_head(item.codex_path, item.src_path)
end
exit(exit_code)
