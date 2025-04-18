return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.enable({"gopls", "marksman", "lua_ls", "zls", "clangd", "texlab", "tinymist"})
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
