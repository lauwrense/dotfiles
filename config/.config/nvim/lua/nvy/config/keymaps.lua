vim.keymap.set("", "<Space>", "<Nop>", { silent = true, remap = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "[t", "<cmd>tabprev<cr>", { remap = true })
vim.keymap.set("n", "]t", "<cmd>tabnext<cr>", { remap = true })
local Telescope = {}
local Neogit = {}

Neogit.open = function()
    require("neogit").open({ cwd = vim.fn.getcwd() })
end

vim.keymap.set("n", "<leader>gu", Neogit.open, { remap = true, silent = true, desc = "Open Neogit" })
