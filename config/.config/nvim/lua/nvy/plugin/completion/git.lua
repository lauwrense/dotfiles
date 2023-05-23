return {
    { "petertriho/cmp-git" },
    { "davidsierradz/cmp-conventionalcommits" },
    ft = { "neogitgitcommitmessage", "gitcommit", "octo" },
    config = function()
        require("cmp").setup.buffer({
            sources = require("cmp").config.sources(
                { { name = "conventionalcommits" }, { name = "git" } },
                { { name = "buffer" } }
            ),
        })

        -- Git
        require("cmp_git").setup({})
    end,
}
