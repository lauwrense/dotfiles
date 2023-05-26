return {
    {
        "m4xshen/hardtime.nvim",
        config = function()
            require("hardtime").setup({
                hint = true,
                disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "NeogitStatus" }
            })
        end
    },
    {
        "ggandor/leap.nvim",
        config = function()
            local leap = require("leap")
            leap.opts = {
                special_keys = {
                    repeat_search = '<tab>',
                    next_phase_one_target = '<tab>',
                    next_target = { '<tab>', ';' },
                    prev_target = { '<S-tab>', ',' },
                    next_group = '<tab>',
                    prev_group = '<S-tab>',
                    multi_accept = '<enter>',
                    multi_revert = '<backspace>',
                }
            }

            leap.add_default_mappings(true)
        end
    },
    {
        "ggandor/flit.nvim",
        config = function()
            require("flit").setup()
        end
    },
    { "ggandor/leap-spooky.nvim", config = true },

    {
        "kylechui/nvim-surround",

        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup()
        end
    }
}
