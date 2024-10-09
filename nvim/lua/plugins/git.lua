return {
    {
        "lewis6991/gitsigns.nvim",
        event = "UIEnter",
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local wk = require("which-key")

                wk.add({
                    {
                        "]c",
                        function()
                            if vim.wo.diff then
                                vim.cmd.normal({ "]c", bang = true })
                            end
                            gs.nav_hunk("next")
                        end,
                        desc = "Next Hunk",
                        expr = true,
                    },
                    {
                        "[c",
                        function()
                            if vim.wo.diff then
                                vim.cmd.normal({ "[c", bang = true })
                            else
                                gs.nav_hunk("prev")
                            end
                        end,

                        desc = "Previous hunk",
                        expr = true,
                    },
                })

                wk.add({
                    mode = "n",
                    { "<leader>h", group = "+git" },
                    { "<leader>hs", gs.stage_hunk, desc = "Stage Hunk" },
                    { "<leader>hS", gs.stage_buffer, desc = "Stage Buffer" },
                    { "<leader>hr", gs.reset_hunk, desc = "Reset Hunk" },
                    { "<leader>hR", gs.reset_buffer, desc = "Reset Buffer" },
                    {
                        "<leader>hu",
                        gs.undo_stage_hunk,
                        desc = "Undo Stage Hunk",
                    },
                    { "<leader>hp", gs.preview_hunk, desc = "Preview Hunk" },
                    {
                        "<leader>hb",
                        function()
                            gs.blame_line({ full = true })
                        end,
                        desc = "Blame Line",
                    },
                    { "<leader>ht", group = "+toggle" },
                    {
                        "<leader>htb",
                        gs.toggle_current_line_blame,
                        desc = "Blame line",
                    },
                    {
                        "<leader>htd",
                        gs.toggle_deleted,
                        desc = "Deleted",
                    },
                    {
                        "<leader>hd",
                        function()
                            gs.diffthis("~")
                        end,
                        desc = "Diff",
                    },
                    {
                        mode = "v",
                        {
                            "<leader>hs",
                            function()
                                gs.stage_hunk({
                                    vim.fn.line("."),
                                    vim.fn.line("v"),
                                })
                            end,
                            desc = "Stage Hunk",
                        },
                        {
                            "<leader>hr",
                            function()
                                gs.reset_hunk({
                                    vim.fn.line("."),
                                    vim.fn.line("v"),
                                })
                            end,
                            desc = "Reset Hunk",
                        },
                    },
                    {
                        {
                            "ih",
                            ":<c-u>Gitsigns select_hunk<cr>",
                            desc = "Select hunk",
                            mode = { "o", "x" },
                        },
                    },
                })
            end,
        },
    },
    {
        "NeogitOrg/neogit",
        cmd = "Neogit",
        keys = {
            { "<leader>hU", "<cmd>Neogit<cr>", desc = "Open Neogit" },
        },
        opts = {
            disable_builtin_notifications = true,
        },
    },
}
