using CosmiXs
using Documenter

DocMeta.setdocmeta!(CosmiXs, :DocTestSetup, :(using CosmiXs); recursive=true)

makedocs(;
    modules=[CosmiXs],
    authors="Original Authors, and Aurelio Amerio",
    repo="https://github.com/aurelio-amerio/CosmiXs.jl/blob/{commit}{path}#{line}",
    sitename="CosmiXs",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://aurelio-amerio.github.io/CosmiXs.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/aurelio-amerio/CosmiXs.jl",
    devbranch="main",
)
