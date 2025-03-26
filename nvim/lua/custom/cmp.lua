local M = {}

M.enable_lsp = function()
    vim.b.completion_lsp = true
end

M.disable_lsp = function()
    vim.b.completion_lsp = false
end

M.toggle_lsp = function()
    vim.b.completion_lsp = not vim.b.completion_lsp or false
end

return M
