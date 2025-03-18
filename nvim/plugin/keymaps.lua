vim.keymap.set("n", "<M-/>", "<c-w>5>")
vim.keymap.set("n", "<M-m>", "<c-w>5<")
vim.keymap.set("n", "<M-,>", "<c-w>+")
vim.keymap.set("n", "<M-.>", "<c-w>-")

vim.keymap.set("n", "]q", "<cmd>cnext<cr>")
vim.keymap.set("n", "[q", "<cmd>cprev<cr>")

vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>")
vim.keymap.set("n", "K", function()
    local size = vim.wo.colorcolumn or 80

    vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, {
            max_height = size,
            max_width = size,
        })

    vim.lsp.buf.hover()
end)

if vim.version.lt(vim.version(), "0.11") then
    vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename)
    vim.keymap.set("n", "<leader>lca", vim.lsp.buf.code_action)
    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references)
    vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation)
    vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition)
    vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition)
else
    vim.print("EDIT KEYMAPS")
end
