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


            wk.add({
                {"<leader>f", group = "+find"},
                {
                    { "]",  group = "+next" },
                    { "]t", "<cmd>tabnext<cr>", desc = "Next tab" },
                },
                {
                    { "[",  group = "+prev" },
                    { "[t", "<cmd>tabprev<cr>", desc = "Prev tab" },
                }
            })
        end
    },
}
