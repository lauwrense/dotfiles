vim.keymap.set("", "<Space>", "<Nop>", { silent = true, remap = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local Telescope = {}
local Neogit = {}

Neogit.open = function()
    require("neogit").open({ cwd = vim.fn.getcwd() })
end

Telescope.find_files = function()
    require("telescope.builtin").find_files({
        layout_config = {
            preview_width = 0.6,
            preview_cutoff = 50,
        },
    })
end

Telescope.grep_string = function()
    require("telescope.builtin").grep_string()
end

Telescope.live_grep = function()
    require("telescope.builtin").live_grep()
end

Telescope.help_tags = function()
    require("telescope.builtin").help_tags()
end

Telescope.man_pages = function()
    require("telescope.builtin").man_pages()
end

vim.keymap.set("n", "<leader>gu", Neogit.open, { remap = true, silent = true, desc = "Open Neogit" })
vim.keymap.set("n", "<leader>ff", Telescope.find_files, { remap = true, desc = "Find Files" })
vim.keymap.set("n", "<leader>fs", Telescope.grep_string, { remap = true, desc = "Grep String" })
vim.keymap.set("n", "<leader>fg", Telescope.live_grep, { remap = true, desc = "Live Grep" })
vim.keymap.set("n", "<leader>fh", Telescope.help_tags, { remap = true, desc = "Help Tags" })
vim.keymap.set("n", "<leader>fm", Telescope.man_pages, { remap = true, desc = "Man Pages" })
