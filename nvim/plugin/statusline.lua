vim.api.nvim_create_autocmd("Colorscheme", {
    group = vim.api.nvim_create_augroup("SetColorScheme", {}),
    callback = function()
        require("custom.highlights")
    end,
})

vim.o.statusline = "%{%v:lua.require'custom.statusline'.render()%}"
vim.g.qf_disable_statusline = true
