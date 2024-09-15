return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",

        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
        },
        config = function(_, opts)
            require("which-key").setup(opts)

            local wk = require("which-key")

            wk.add({
                { "<leader>f", group = "+fzf" },
                {
                    { "]",  group = "+next" },
                    { "]t", "<cmd>tabnext<cr>", desc = "Next tab" },
                },
                {
                    { "[",  group = "+prev" },
                    { "[t", "<cmd>tabprev<cr>", desc = "Prev tab" },
                }
            })
        end
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
