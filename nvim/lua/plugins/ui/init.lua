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
                neotest = true,
                blink_cmp = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                        ok = { "undercurl" },
                    },
                },
            },
        },
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = { "BufNew", "BufRead", "BufEnter" },
        submodules = false,
        opts = {
            blacklist = {
                "comment",
            },
        },
        config = function(_, opts)
            require("rainbow-delimiters.setup").setup(opts)
        end,
    },
    {
        "j-hui/fidget.nvim",
        event = { "UIEnter" },
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
}
