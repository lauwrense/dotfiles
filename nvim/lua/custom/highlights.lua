--- Statusline
vim.api.nvim_set_hl(0, "StatusLineRed", {
    fg = vim.api.nvim_get_hl(0, { name = "DiagnosticError" }).fg,
    bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
})
vim.api.nvim_set_hl(0, "StatusLineBlue", {
    fg = vim.api.nvim_get_hl(0, { name = "Function" }).fg,
    bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
})
vim.api.nvim_set_hl(0, "StatusLineYellow", {
    fg = vim.api.nvim_get_hl(0, { name = "Type" }).fg,
    bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
})
vim.api.nvim_set_hl(0, "StatusLineOrange", {
    fg = vim.api.nvim_get_hl(0, { name = "Boolean" }).fg,
    bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
})
vim.api.nvim_set_hl(0, "StatusLinePurple", {
    fg = vim.api.nvim_get_hl(0, { name = "Conditional" }).fg,
    bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
})
vim.api.nvim_set_hl(0, "StatusLineGreen", {
    fg = vim.api.nvim_get_hl(0, { name = "String" }).fg,
    bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
})

vim.api.nvim_set_hl(0, "StatusLineDiffBranch", {
    fg = vim.api.nvim_get_hl(0, { name = "Comment" }).fg,
    bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
    bold = true,
})

vim.api.nvim_set_hl(0, "StatusLineDiffAdded", {
    fg = vim.api.nvim_get_hl(0, { name = "Green" }).fg,
    bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
})

vim.api.nvim_set_hl(0, "StatusLineDiffChanged", {
    fg = vim.api.nvim_get_hl(0, { name = "Yellow" }).fg,
    bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
})

vim.api.nvim_set_hl(0, "StatusLineDiffRemoved", {
    fg = vim.api.nvim_get_hl(0, { name = "Red" }).fg,
    bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
})

vim.api.nvim_set_hl(0, "StatusLineText", {
    fg = vim.api.nvim_get_hl(0, {name = "StatusLine"}).fg,
    bg = vim.api.nvim_get_hl(0, {name = "StatusLine"}).bg,
})
