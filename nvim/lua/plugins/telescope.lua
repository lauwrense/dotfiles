return {
    "nvim-telescope/telescope.nvim",
    name = "Telescope",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    cmd = {
        "Telescope",
    },
    keys = {
        {
            "<leader>ff",
            function()
                require("telescope.builtin").find_files({
                    layout_config = {
                        preview_width = 0.6,
                        preview_cutoff = 50,
                    },
                })
            end,
            remap = true,
            desc = "Find Files",
        },
        {
            "<leader>fs",
            function()
                require("telescope.builtin").grep_string()
            end,
            remap = true,
            desc = "Grep String",
        },
        {
            "<leader>fg",
            function()
                require("telescope.builtin").live_grep()
            end,
            remap = true,
            desc = "Live Grep",
        },
        {
            "<leader>fh",
            function()
                require("telescope.builtin").help_tags()
            end,
            remap = true,
            desc = "Help Tags",
        },
        {
            "<leader>fm",
            function()
                require("telescope.builtin").man_pages()
            end,
            remap = true,
            desc = "Man Pages",
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

                file_ignore_patterns = { "target" },
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
                    find_command = {
                        "rg",
                        "--hidden",
                        "--files",
                        "--glob",
                        "!**/.git/**",
                        "--ignore",
                    },
                },
            },
        }

        local update_color = function(opts)
            local TelescopePrompt = {
                TelescopePromptNormal = {
                    bg = vim.api.nvim_get_hl(0, { name = "CursorLine" }).bg,
                },
                TelescopePromptBorder = {
                    fg = vim.api.nvim_get_hl(0, { name = "CursorLine" }).bg,

                    bg = vim.api.nvim_get_hl(0, { name = "CursorLine" }).bg,
                },
                TelescopePromptTitle = {
                    fg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
                    bg = vim.api.nvim_get_hl(0, { name = "Character" }).fg,
                },
                TelescopePreviewNormal = {
                    bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
                },
                TelescopePreviewBorder = {
                    fg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
                    bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
                },
                TelescopePreviewTitle = {
                    fg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
                    bg = vim.api.nvim_get_hl(0, { name = "Conditional" }).fg,
                },
                TelescopeResultsNormal = {
                    bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
                },
                TelescopeResultsBorder = {
                    fg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
                    bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
                },
                TelescopeResultsTitle = {
                    fg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
                    bg = vim.api.nvim_get_hl(0, { name = "Function" }).fg,
                },
            }
            for hl, col in pairs(TelescopePrompt) do
                vim.api.nvim_set_hl(0, hl, col)
            end
        end

        local update_color_group =
            vim.api.nvim_create_augroup("TelescopeUpdateColor", {
                clear = true,
            })
        vim.api.nvim_create_autocmd("Colorscheme", {
            group = update_color_group,
            callback = function(opts)
                update_color(opts)
            end,
        })

        update_color({})
        require("telescope").setup(telescope_config)
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("notify")
    end,
}
