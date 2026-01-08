vim.pack.add({
    { src = "https://github.com/kylechui/nvim-surround" },
    { src = "https://github.com/Wansmer/treesj" }
}, { confirm = false })

require("nvim-surround").setup()

vim.keymap.set('n', '<leader>m', require('treesj').toggle)
vim.keymap.set('n', '<leader>M', function()
    require('treesj').toggle({ split = { recursive = true } })
end)
