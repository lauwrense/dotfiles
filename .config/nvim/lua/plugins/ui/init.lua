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
        "j-hui/fidget.nvim",
        opts = {
            notification = {
                window = {
                    winblend = 0,
                },
            }
        },
    },
    {dir = "~/projects/navy"},
    {"rebelot/heirline.nvim"},
}