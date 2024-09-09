return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",

        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {},
        config = function(_, opts)
            require("which-key").setup(opts)

            local wk = require("which-key")

            wk.register(
                { ["t"] = { ":<c-u>tabnext<cr>", "Next tab" } },

                { mode = { "n" }, prefix = "]", name = "+next" }
            )

            wk.register(
                { ["t"] = { ":<c-u>tabnext<cr>", "Prev tab" } },
                { mode = { "n" }, prefix = "[", name = "+prev" }
            )
        end
    },
}
