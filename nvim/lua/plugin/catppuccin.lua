vim.pack.add({
    {
        src = "https://github.com/catppuccin/nvim",
        name = "catppuccin",
    },
}, {confirm = false})

require("catppuccin").setup({
    lsp_styles = {
        underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
            ok = { "undercurl" },
        },
    },
})
