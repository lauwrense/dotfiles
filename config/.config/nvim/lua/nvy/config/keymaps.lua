vim.keymap.set("", "<Space>", "<Nop>", { silent = true, remap = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "i", "v" }, "<Up>", "<Nop>", { silent = true, remap = true })
vim.keymap.set({ "n", "i", "v" }, "<Down>", "<Nop>", { silent = true, remap = true })
vim.keymap.set({ "n", "i", "v" }, "<Left>", "<Nop>", { silent = true, remap = true })
vim.keymap.set({ "n", "i", "v" }, "<Right>", "<Nop>", { silent = true, remap = true })


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

vim.keymap.set("n", "<leader>gu", Neogit.open, { remap = true, silent = true })
vim.keymap.set("n", "<leader>ff", Telescope.find_files, { remap = true })
