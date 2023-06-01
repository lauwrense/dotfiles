return {
    {
        "m4xshen/hardtime.nvim",
        config = function()
            require("hardtime").setup({
                hint = true,
                disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "NeogitStatus", "crates.nvim",
                    "lspsagaoutline" }
            })
        end
    },
    {
        "ggandor/leap.nvim",
        config = function()
            local leap = require("leap")
            leap.add_default_mappings(true)
            require("leap").opts.special_keys = {
                repeat_search = '<tab>',
                next_phase_one_target = '<tab>',
                next_target = { '<tab>', ';' },
                prev_target = { '<S-tab>', ',' },
                next_group = '<space>',
                prev_group = '<S-tab>',
                multi_accept = '<enter>',
                multi_revert = '<backspace>',
            }
        end
    },
    {
        "ggandor/flit.nvim",
        config = function()
            require("flit").setup({
                labeled_modes = "vno",
            })
        end
    },
    {
        "ggandor/leap-spooky.nvim",
        config = function()
            require("leap-spooky").setup({
                affixes = {
                    magnetic = { window = 'm', cross_window = 'M' },
                    remote = { window = 'r', cross_window = 'R' },
                },
                paste_on_remote_yank = false,
            })
        end
    },

    {
        "kylechui/nvim-surround",

        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup()
        end
    }
}
