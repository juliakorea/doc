push!(LOAD_PATH, "scripts")

include("translate.jl")

function do_codex_update()
    function run_cmd(cmd)
       println(join(cmd.exec, " "))
       run(cmd)
    end

    juliadoc = "../julia/doc"
    if isdir(juliadoc)
       run_cmd(`cp $juliadoc/index.rst codex/julia/doc/`)
       for dir in ["manual" "devdocs" "stdlib"]
           run_cmd(`cp -r $juliadoc/$dir codex/julia/doc/`)
       end
    end
end

do_codex_update()
