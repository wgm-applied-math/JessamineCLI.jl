using Aqua

@testset "Aqua" begin
    Aqua.test_all(
        JessamineCLI;
        stale_deps=(ignore=[:Revise],),
        deps_compat=(ignore=[:Jessamine, :JessamineSymbolics],),
    )
end
