return {
    { "nvim-tree/nvim-web-devicons" },
    -- Colorschemes
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 10000,
        lazy = false,
        opts = {
            flavour = "frappe",
            integrations = {
                cmp = true,
                fidget = true,
                illuminate = true,
                mason = true,
                neogit = true,
                neotest = true,
                indent_backline = {
                    colored_indent_levels = false,
                },

            },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "VeryLazy",
        opts = {
            whitespace = { remove_blankline_trail = false },
            scope = {
                enabled = false,
            }
        }
    },
    { "HiPhish/rainbow-delimiters.nvim", event = "VeryLazy" },
    {
        "RRethy/vim-illuminate",
        event = "VeryLazy",
        config = function()
            require("illuminate").configure({
                filetypes_denylist = {
                    "dirvish",
                    "fugitive",
                    "NvimTree",
                    "TelescopePrompt",
                },
            })
        end,
    },
    {
        "rcarriga/nvim-notify",
        config = function()
            ---@diagnostic disable-next-line:missing-fields
            require("notify").setup({
                max_width = 40,
            })

            vim.notify = require("notify")
        end,
    },
    {
        "j-hui/fidget.nvim",
        opts = {
            notification = {
                window = {
                    winblend = 0,
                },
            }
        },
    },
}
