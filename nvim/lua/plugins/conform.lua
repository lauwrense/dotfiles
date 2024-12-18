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
                lua = { "stylua" },
                go = { "goimports", "gofmt" },
                zig = { "zigfmt" },
                markdown = { "mdformat" },
            },
        },
    },
}
