return {
    {
        "williamboman/mason-lspconfig.nvim",
        event = {"VeryLazy"},
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function ()
            require("mason").setup()
            require("mason-lspconfig").setup()
            local lspconfig = require("lspconfig")

            lspconfig["gopls"].setup({})
            lspconfig["marksman"].setup({})
            lspconfig["lua_ls"].setup({})
            lspconfig["zls"].setup({})
            lspconfig["clangd"].setup({})
        end
    },
    {
        "nvim-java/nvim-java",
        ft = "java",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        config = function ()
            require('java').setup()
            require('lspconfig').jdtls.setup({})
        end
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
