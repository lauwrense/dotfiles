local qf_group = vim.api.nvim_create_augroup("user.quickfix", {})
vim.api.nvim_create_autocmd({ "BufRead" }, {
    group = qf_group,
    pattern = "quickfix",
    callback = function()
        vim.opt_local.colorcolumn = ""
        vim.opt_local.signcolumn = "no"
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.syntax = ""
    end,
})

local function cmp_item(a, b)
    local fname = {
        a = vim.api.nvim_buf_get_name(a.bufnr),
        b = vim.api.nvim_buf_get_name(b.bufnr),
    }

    if a.bufnr == b.bufnr then
        return (a.lnum == b.lnum) and (a.col < b.col) or (a.lnum < b.lnum)
    else
        return #fname.a < #fname.b
    end
end

vim.api.nvim_create_autocmd({ "QuickFixCmdPost" }, {
    group = qf_group,
    callback = function()
        local winid = vim.api.nvim_get_current_win()
        local is_loclist = vim.fn.getwininfo(winid)[1]["loclist"]
            == 1
        if is_loclist then
            local loclist = vim.fn.getloclist(0)
            table.sort(loclist, cmp_item)
            vim.fn.setloclist(0, loclist, "r")
        else
            local qflist = vim.fn.getqflist()
            table.sort(qflist, cmp_item)
            vim.fn.setqflist(qflist, "r")
        end
    end,
})

vim.opt.quickfixtextfunc = "v:lua.require'user.qf'.quickfixtextfunc"
