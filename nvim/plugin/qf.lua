-- FUNCTIONS
local function copen_no_focus()
    local win = vim.api.nvim_get_current_win()
    vim.cmd("copen")
    vim.api.nvim_set_current_win(win)
end

-- KEYBINDS
vim.keymap.set("n", "]q", function()
    if vim.fn.getqflist({ size = 1 }).size < 1 then
        vim.notify("Empty Quickfix", vim.log.levels.INFO)
        return
    end

    copen_no_focus()
    vim.cmd("cnext")
end, { desc = "Next on quickfix list" })

vim.keymap.set("n", "[q", function()
    if vim.fn.getqflist({ size = 1 }).size < 1 then
        vim.notify("Empty Quickfix", vim.log.levels.INFO)
        return
    end

    copen_no_focus()
    vim.cmd("cprev")
end, { desc = "Next on quickfix list" })

-- AUTOGROUPS
local qf_group = vim.api.nvim_create_augroup("QuickFixGroup", {})
vim.api.nvim_create_autocmd({ "BufRead" }, {
    group = qf_group,
    pattern = "quickfix",
    callback = function()
        vim.opt_local.colorcolumn = ""
        vim.opt_local.signcolumn = "no"
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end,
})
