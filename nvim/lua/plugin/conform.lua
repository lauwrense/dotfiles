vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim" },
})

require("conform").setup({
    formatters_by_ft = {
        markdown = { "mdformat" },
        lua = { "stylua" },
        zig = { "zigfmt" },
    },
    default_format_opts = {
        lsp_format = "fallback",
    },
})
vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
