using Documenter
using Sky130PDK

# Normalize the documenter key if it's not already base64-encoded
using Base64
documenter_key = get(ENV, "DOCUMENTER_KEY", "")
try
    base64decode(documenter_key)
catch e
    if isa(e, ArgumentError)
        if !endswith(documenter_key, "\n")
            global documenter_key = string(documenter_key, "\n")
        end
        ENV["DOCUMENTER_KEY"] = base64encode(documenter_key)
    else
        rethrow(e)
    end
end

makedocs(
    sitename = "Sky130PDK",
    format = Documenter.HTML(),
    modules = [Sky130PDK]
)

deploydocs(
    repo = "github.com/JuliaComputing/Sky130PDK.jl.git",
    branch = "docs",
)
