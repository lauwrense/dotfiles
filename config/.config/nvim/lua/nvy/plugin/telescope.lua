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
    config = function()
        local builtin = require("telescope.builtin")
        local action = require("telescope.actions")
        local action_layout = require("telescope.actions.layout")
        local themes = require("telescope.themes")

        local telescope_config = {
            defaults = {
                file_sorter = require("telescope.sorters").get_fuzzy_file,
                file_ignore_patterns = { "target", "build" },
                layout_config = {},
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

        local TelescopeKeymaps = {}

        TelescopeKeymaps.find_files = function()
            builtin.find_files({
                layout_config = {
                    preview_width = 0.6,
                    preview_cutoff = 50,
                },
            })
        end

        require("telescope").setup(telescope_config)
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("heading")

        vim.keymap.set("n", "<leader>ff", TelescopeKeymaps.find_files, { remap = true })
    end,
}
