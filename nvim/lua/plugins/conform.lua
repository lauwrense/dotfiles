return {
    {
        "stevearc/conform.nvim",
        event = {"BufWritePre"},
        init = function()
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
        opts = {
            formatters_by_ft = {
                c = { "clang-format" },
                cpp = { "clang-format" },
                go = { "goimports", "gofmt" },
                lua = { "stylua" },
                markdown = { "mdformat" },
                ocaml = {"ocamlformat"},
                sh = { "shfmt" },
                zig = { "zigfmt" },
            },
        },
    },
}
