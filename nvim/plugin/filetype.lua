local ft_group = vim.api.nvim_create_augroup("CustomFtGroup",{})
vim.api.nvim_create_autocmd({"VimEnter"}, {
    group = ft_group,
    callback = function()
        local ft = vim.filetype.match({
            buf = vim.api.nvim_get_current_buf()
        })

        if ft ~= nil and type(ft) == "string" then
            vim.cmd("setfiletype " .. ft)
        end
    end
})


