vim.api.nvim_create_autocmd("Colorscheme", {
    group = vim.api.nvim_create_augroup("SetColorScheme", {}),
    callback = function()
        require("custom.highlights")
    end,
})

vim.o.statusline = "%{%v:lua.require'custom.statusline'.render()%}"

-- HACK: this solves issue describe at neovim/neovim#27731
vim.api.nvim_create_autocmd("Filetype", {
    pattern = "qf",
    group = vim.api.nvim_create_augroup("SetStatusQuickFix", {}),
    callback = function()
        vim.o.statusline = "%{%v:lua.require'custom.statusline'.render()%}"
    end,
})
