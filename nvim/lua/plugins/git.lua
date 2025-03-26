return {
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                map("n", "]c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    end
                    gs.nav_hunk("next")
                end, {
                    desc = "Next Hunk",
                })

                map("n", "[c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gs.nav_hunk("prev")
                    end
                end, { desc = "Previous hunk" })

                map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
                map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
                map("v", "<leader>hs", function()
                    gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "Stage Hunk" })
                map("v", "<leader>hr", function()
                    gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "Reset Hunk" })
                map(
                    "n",
                    "<leader>hS",
                    gs.stage_buffer,
                    { desc = "Stage Buffer" }
                )
                map(
                    "n",
                    "<leader>hu",
                    gs.undo_stage_hunk,
                    { desc = "Undo Stage Hunk" }
                )
                map(
                    "n",
                    "<leader>hR",
                    gs.reset_buffer,
                    { desc = "Reseet Buffer" }
                )
                map(
                    "n",
                    "<leader>hp",
                    gs.preview_hunk,
                    { desc = "Preview Hunk" }
                )
                map("n", "<leader>hb", function()
                    gs.blame_line({ full = true })
                end, { desc = "Blame Line" })
                map(
                    "n",
                    "<leader>tb",
                    gs.toggle_current_line_blame,
                    { desc = "Blame Line" }
                )
                map("n", "<leader>hd", gs.diffthis, { desc = "Diff" })
                map("n", "<leader>hD", function()
                    gs.diffthis("~")
                end, { desc = "Diff" })
                map("n", "<leader>td", gs.toggle_deleted, { desc = "Deleted" })
                map(
                    { "o", "x" },
                    "ih",
                    ":<C-U>Gitsigns select_hunk<CR>",
                    { desc = "Select Hunk" }
                )
            end,
        },
    },
    {
        "NeogitOrg/neogit",
        cmd = "Neogit",
        dependencies = {"nvim-lua/plenary.nvim"},
        keys = {
            { "<leader>hU", "<cmd>Neogit<cr>", desc = "Open Neogit" },
        },
        opts = {
            disable_builtin_notifications = true,
        },
    },
    {
        "sindrets/diffview.nvim",
        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewToggleFiles",
            "DiffviewFocusFiles",
            "DiffviewRefresh",
            "DiffviewFileHistory",
        },
    },
}
