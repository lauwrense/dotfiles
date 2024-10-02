return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = {"FzfLua"},
    keys = {
        {
            "<leader>ff",
            function()
                require("fzf-lua").files()
            end,
            desc = "Find Files"
        },
        {
            "<leader>fs",
            function()
                require("fzf-lua").grep()
            end,
            desc = "Grep String"
        },
        {
            "<leader>fg",
            function()
                require("fzf-lua").live_grep()
            end,
            desc = "Live Grep"
        },
        {
            "<leader>fh",
            function()
                require("fzf-lua").helptags()
            end,
            desc = "Help Tags"
        },
        {
            "<leader>fm",
            function()
                require("fzf-lua").manpages()
            end,
            desc = "Man Pages"
        },
        { "<leader>fB", "<cmd>FzfLua tabs previewer=builtin<cr>", desc = "Tabs" },
        { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
    },
    config = function()
        require("fzf-lua").setup({
            fzf_colors = true,
            winopts = {
                preview = {
                    default = "bat",
                    border = "noborder",
                },
            },
            previewers = {
                bat = {
                    theme = "Catppuccin Frappe",
                },
            },
            files = {
                cwd_prompt = false,
            },
            keymap = {
                builtin = {
                    ["<c-f>"] = "preview-page-down",
                    ["<c-b>"] = "preview-page-up",
                },
                fzf = {
                    ["ctrl-f"] = "preview-page-down",
                    ["ctrl-b"] = "preview-page-up",
                }
            }
        })

        vim.api.nvim_set_hl(0, "FzfLuaBorder", {
            fg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg,
            bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg,
        })
    end
}
