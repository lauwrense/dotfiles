vim.pack.add({
    { src = "https://github.com/stevearc/oil.nvim" },
})

require("oil").setup({
    columns = { "icon", "permissions", "size", "mtime" },
    keymaps = {
        ["<leader>o"] = { "actions.close", mode = "n" },
    },
})
vim.keymap.set("n", "<leader>o", require("oil").open)
