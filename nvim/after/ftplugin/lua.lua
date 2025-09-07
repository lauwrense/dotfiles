vim.opt.colorcolumn = "80"

vim.pack.add({
    { src = "https://github.com/folke/lazydev.nvim" }
}, { load = true, confirm = false })

require("lazydev").setup({
    library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
})
