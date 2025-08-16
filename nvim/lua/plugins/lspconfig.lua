return {
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        config = function()
            vim.lsp.enable ({
                "clangd",
                "gopls",
                "lua_ls",
                "marksman",
                "tinymist",
                "zls",
            })
        end,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
