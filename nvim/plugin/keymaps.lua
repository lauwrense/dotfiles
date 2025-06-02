vim.keymap.set("n", "<M-/>", "<c-w>5>")
vim.keymap.set("n", "<M-m>", "<c-w>5<")
vim.keymap.set("n", "<M-,>", "<c-w>+")
vim.keymap.set("n", "<M-.>", "<c-w>-")

vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>")

vim.keymap.set("n", "K", function()
    local size = tonumber(vim.wo.colorcolumn) or 80

    vim.lsp.buf.hover({
        max_height = size,
        max_width = size,
    })
end)

vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references)
vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation)
vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition)
vim.keymap.set("n", "<leader>lo", vim.lsp.buf.document_symbol)

vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help)
vim.keymap.set("n", "gr", "gr", { nowait = true, noremap = true })
