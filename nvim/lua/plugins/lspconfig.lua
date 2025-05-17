return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.enable({"gopls", "marksman", "lua_ls", "zls", "clangd", "texlab", "tinymist"})
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
