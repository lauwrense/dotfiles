return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            lspconfig["gopls"].setup({})
            lspconfig["marksman"].setup({})
            lspconfig["lua_ls"].setup({})
            lspconfig["zls"].setup({})
            lspconfig["clangd"].setup({})
            lspconfig["texlab"].setup({})
            lspconfig["tinymist"].setup({})
        end,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true },
}
