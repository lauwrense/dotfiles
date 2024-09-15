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
        "rcarriga/nvim-notify",
        config = function()
            local stages = require("notify.stages.fade_in_slide_out")("top_down")
            ---@diagnostic disable-next-line:missing-fields
            require("notify").setup({
                max_width = 40,
                stages = {
                    function(...)
                        local opts = stages[1](...)
                        if opts then
                            opts.border = "single"
                            opts.row = opts.row + 1
                        end

                        return opts
                    end,

                    ---@diagnostic disable-next-line: param-type-mismatch
                    unpack(stages, 2),
                },
                on_open = function(window)
                    vim.api.nvim_win_set_config(window, {
                        zindex = 1000,
                    })
                end
            })

            vim.notify = require("notify").notify
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
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            ---@module "noice.nvim"
            cmdline = {
                enabled = false
            },
            messages = {
                enabled = false,
            },
            popupmenu = {
                enabled = false,
            },
            lsp = {
                progress = {
                    enabled = false,
                },
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
                hover = {
                    opts = {
                        size = {
                            max_height = 20,
                            max_width = 80,
                        },
                    },
                },
                signature = {
                    opts = {
                        size = {
                            max_height = 20,
                            max_width = 80,
                        },
                    },
                },
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
        }
    }
}
