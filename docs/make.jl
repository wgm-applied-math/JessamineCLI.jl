using JessamineCLI
using Documenter

DocMeta.setdocmeta!(JessamineCLI, :DocTestSetup, :(using JessamineCLI); recursive=true)

makedocs(;
    modules=[JessamineCLI],
    authors="W. Garrett Mitchener <mitchenerg@charleston.edu> and others",
    sitename="JessamineCLI.jl",
    format=Documenter.HTML(;
        canonical="https://wgmitchener.github.io/JessamineCLI.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/wgmitchener/JessamineCLI.jl",
    devbranch="main",
)
