return {
    {
        "stevearc/conform.nvim",
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>F",
                function()
                    require("conform").format({
                        async = true,
                        lsp_format = "fallback",
                    })
                end,
                desc = "Format buffer",
            },
        },
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
