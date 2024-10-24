return {
    { "nvim-tree/nvim-web-devicons", lazy = true },
    -- Colorschemes
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 10000,
        lazy = false,
        opts = {
            flavour = "frappe",
            integrations = {
                fidget = true,
                mason = true,
                notify = true,
                neotest = true,
                lsp_trouble = true,
                which_key = true,
            },
        },
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = { "BufNew", "BufRead" },
    },
    {
        "j-hui/fidget.nvim",
        event = { "VeryLazy" },
        opts = {
            notification = {
                window = {
                    winblend = 0,
                },
            },
        },
        config = function(_, opts)
            local fidget = require("fidget")
            fidget.setup(opts)

            vim.notify = fidget.notify
        end,
    },
    {
        dir = "~/projects/luip.nvim",
        opts = {},
    },
}
