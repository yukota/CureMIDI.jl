push!(LOAD_PATH,"../src/")

using Documenter
using CureMIDI

makedocs(
    sitename="CureMIDI.jl",
    pages= [
        "index.md",
        "reference.md"
    ]
    )

deploydocs(
    repo = "github.com/yukota/CureMIDI.jl.git",
    )