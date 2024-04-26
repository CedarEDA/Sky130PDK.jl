using Documenter
using Sky130PDK

makedocs(
    sitename = "Sky130PDK",
    format = Documenter.HTML(),
    modules = [Sky130PDK],
)

deploydocs(
    repo = "github.com/CedarEDA/Sky130PDK.jl.git",
)
