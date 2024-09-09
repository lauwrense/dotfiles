return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local wk = require("which-key")

                wk.register({
                    ["]c"] = {
                        function()
                            if vim.wo.diff then
                                return "]c"
                            end
                            vim.schedule(function()
                                gs.next_hunk()
                            end)
                            return "<Ignore>"
                        end,
                        "Next hunk",
                    },
                    ["[c"] = {
                        function()
                            if vim.wo.diff then
                                return "[c"
                            end

                            vim.schedule(function()
                                gs.prev_hunk()
                            end)
                            return "<Ignore>"
                        end,

                        "Prev hunk",
                    },
                }, { expr = true })

                wk.register({
                    name = "+git",
                    s = { gs.stage_hunk, "Stage hunk" },
                    r = { gs.reset_hunk, "Reset hunk" },
                    S = { gs.stage_buffer, "Stage buffer" },
                    u = { gs.undo_stage_hunk, "Undo stage hunk" },
                    R = { gs.reset_hunk, "Reset buffer" },
                    p = { gs.preview_hunk, "Preview hunk" },
                    b = {
                        function()
                            gs.blame_line({ full = true })
                        end,
                        "Blame line",

                    },
                    t = {
                        name = "+toggle",
                        b = { gs.toggle_current_line_blame, "Blame line" },
                        d = { gs.toggle_deleted, "Deleted" },
                    },
                    d = { gs.diffthis, "Diff" },

                    D = {
                        function()
                            if vim.wo.diff then
                                vim.wo.diff = false
                            else
                                gs.diffthis("~")
                            end
                        end,
                        "Diff",
                    },
                }, { prefix = "<leader>h" })

                wk.register({
                    name = "+git",

                    s = {
                        function()
                            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                        end,
                        "Stage hunk",
                    },
                    r = {
                        function()
                            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                        end,
                        "Reset hunk",
                    },
                }, { prefix = "<leader>h", mode = "v" })

                wk.register(
                    { ["ih"] = { ":<c-u>Gitsigns select_hunk<cr>", "Select hunk" } },

                    { mode = { "o", "x" } }
                )
            end,

        },
    },

    { "sindrets/diffview.nvim", config = true },
    {

        "NeogitOrg/neogit",
        cmd = "Neogit",
        keys = {
            { "<leader>hU", "<cmd>Neogit<cr>", desc = "Open Neogit" },
        },
        opts = {

            disable_builtin_notifications = true,
            integrations = {
                diffview = true,
            },
        },
    },
}
