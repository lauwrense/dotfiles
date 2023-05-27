return {
    "petertriho/cmp-git",
    "davidsierradz/cmp-conventionalcommits",
    event = "VeryLazy",
    ft = { "neogitcommitmessage", "gitcommit", "octo" },
    config = function()
        require("cmp").setup.filetype({ "gitcommit", "octo", "neogitcommitmessage" }, {
            sources = require("cmp").config.sources(
                { { name = "conventionalcommits" }, { name = "git" } },
                { { name = "buffer" } }
            ),
        })

        -- Git
        require("cmp_git").setup({})
    end,
}
