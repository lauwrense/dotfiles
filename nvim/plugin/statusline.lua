vim.api.nvim_set_hl(0, "Statusline", { bg = "NONE" })
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, "Statusline", {
            bg = "NONE",
        })
    end,
})

local function bufname()
    local buf_name = vim.api.nvim_buf_get_name(0)
    local buftype = vim.bo.buftype

    if buftype == "help" then
        return vim.fs.basename(buf_name)
    end

    local path = vim.fs.relpath(vim.fn.getcwd(), buf_name)

    if path == '.' then
        path = nil
    end

    local fname = path or "[No Name]"

    return fname
end


function _G.render_statusline()
    local left = table.concat({ bufname(), "%h%m%r" }, " ")
    local right = "%*%y %2l / %2L : %2c   "

    local column = vim.o.columns
    local lwidth = vim.api.nvim_eval_statusline(left, {}).width
    local rwidth = vim.api.nvim_eval_statusline(right, {}).width

    local center_pad = column - (lwidth + rwidth)

    return table.concat({
        left,
        string.rep(" ", center_pad),
        right,
    }, "")
end

vim.opt.statusline = "%{%v:lua._G.render_statusline()%}"
