vim.api.nvim_set_hl(0, "Statusline", { bg = "NONE" })
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, "Statusline", {
            bg = "NONE",
        })
    end,
})

local left = "%{expand('%:.')} %h%m%r"
local center = "%#@comment#%{get(b:,'gitsigns_status_dict','')['head'] }"
local right = "%*%y %2l / %2L : %2c   "

function _G.render_statusline()
    local column = vim.o.columns
    local lwidth = vim.api.nvim_eval_statusline(left, {}).width
    local cwidth = vim.api.nvim_eval_statusline(center, {}).width
    local rwidth = vim.api.nvim_eval_statusline(right, {}).width

    local left_pad = math.floor((column - cwidth) / 2) - lwidth
    local right_pad = math.ceil((column - cwidth) / 2) - rwidth

    return table.concat({
        left,
        string.rep(" ", left_pad),
        center,
        string.rep(" ", right_pad),
        right,
    }, "")
end

vim.o.statusline = "%{%v:lua._G.render_statusline()%}"
vim.api.nvim_create_autocmd("User", {
    pattern = "GitSignsUpdate",
    group = vim.api.nvim_create_augroup("user.statusline.git", {}),
    callback = function()
        vim.cmd.redrawstatus()
    end,
})
