return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("lspconfig")["gopls"].setup({})
            require("lspconfig")["marksman"].setup({})
            require("lspconfig")["lua_ls"].setup({})
            require("lspconfig")["zls"].setup({})
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
