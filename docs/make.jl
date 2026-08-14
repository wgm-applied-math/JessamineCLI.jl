using JessamineCLI
using Documenter

DocMeta.setdocmeta!(JessamineCLI, :DocTestSetup, :(using JessamineCLI); recursive=true)

makedocs(;
    modules=[JessamineCLI],
    authors="W. G. Mitchener <mitchenerg@charleston.edu> and others",
    sitename="JessamineCLI.jl",
    format=Documenter.HTML(;
        canonical="https://wgm-applied-math.github.io/JessamineCLI.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(;
    repo="github.com/wgm-applied-math/JessamineCLI.jl",
    devbranch="main",
    versions = ["stable" => "v^", "v#.#", "dev" =>  "dev"] # Explicitly forces version tracking
)
