vim.api.nvim_create_autocmd("Colorscheme", {
    group = vim.api.nvim_create_augroup("user.statusline.highlights", {}),
    callback = function()
        require("user.highlights")
    end,
})

vim.o.statusline = "%{%v:lua.require'user.statusline'.render()%}"
vim.g.qf_disable_statusline = true
