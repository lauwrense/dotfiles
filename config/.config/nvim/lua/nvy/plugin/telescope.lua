return {
    "nvim-telescope/telescope.nvim",
    name = "Telescope",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "crispgm/telescope-heading.nvim" },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    keys = {},
    config = function()
        local builtin = require("telescope.builtin")
        local action = require("telescope.actions")
        local action_layout = require("telescope.actions.layout")
        local themes = require("telescope.themes")

        local telescope_config = {
            defaults = {
                file_sorter = require("telescope.sorters").get_fuzzy_file,
                file_ignore_patterns = { "target", "build" },
                prompt_prefix = "   ",
                selection_caret = "  ",
                entry_prefix = "  ",
                multi_icon = " + ",
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                        results_width = 0.8,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },
                mappings = {
                    n = {
                        ["<Up>"] = action.nop,
                        ["<Down>"] = action.nop,
                        ["<Left>"] = action.nop,
                        ["<Right>"] = action.nop,
                        ["<M-p>"] = action_layout.toggle_preview,
                    },
                    i = {
                        ["<Up>"] = action.nop,
                        ["<Down>"] = action.nop,
                        ["<Left>"] = action.nop,
                        ["<Right>"] = action.nop,
                        ["<M-p>"] = action_layout.toggle_preview,
                    },
                },
            },
            pickers = {
                find_files = {
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                heading = {
                    treesitter = true,
                },
            },
        }

        require("telescope").setup(telescope_config)
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("heading")
    end,
}
