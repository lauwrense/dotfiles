local qf_group = vim.api.nvim_create_augroup("user.quickfix", {})
vim.api.nvim_create_autocmd({ "BufRead" }, {
    group = qf_group,
    pattern = "quickfix",
    callback = function()
        vim.opt_local.colorcolumn = ""
        vim.opt_local.signcolumn = "no"
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        -- vim.opt_local.syntax = ""
    end,
})
