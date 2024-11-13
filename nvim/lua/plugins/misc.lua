return {
    {
        "folke/which-key.nvim",
        enabled = false,
        event = "VeryLazy",
        opts = {},
        config = function(_, opts)
            require("which-key").setup(opts)

            local wk = require("which-key")

            wk.add({
                { "<leader>f", group = "+fzf" },
                { "<leader>t", group = "+term" },
                { "<leader>l", group = "+list" },
                { "<leader>v", group = "+virt text" },
            })
        end,
    },
}
