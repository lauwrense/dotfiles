return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",
        },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            lspconfig["gopls"].setup({capabilities = capabilities})
            lspconfig["marksman"].setup({capabilities = capabilities})
            lspconfig["lua_ls"].setup({capabilities = capabilities})
            lspconfig["zls"].setup({capabilities = capabilities})
            lspconfig["clangd"].setup({capabilities = capabilities})
            lspconfig["texlab"].setup({capabilities = capabilities})
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
