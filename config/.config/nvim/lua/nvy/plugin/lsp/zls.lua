local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}
require("lspconfig")["zls"].setup({
    cmd = { "zls" },
    filetype = { "zig", "zir" },
    single_file_support = true,
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")
        vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
        vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>")
        vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>")
        vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
        vim.keymap.set("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")
        vim.keymap.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")
        vim.keymap.set("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")
        vim.keymap.set("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")
        vim.keymap.set("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")
        vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
        vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
        vim.keymap.set("n", "[E", function()
            require("lspsaga.diagnostic"):goto_prev({
                severity = vim.diagnostic.severity.ERROR,
            })
        end)
        vim.keymap.set("n", "]E", function()
            require("lspsaga.diagnostic"):goto_next({
                severity = vim.diagnostic.severity.ERROR,
            })
        end)
        vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>")
        vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")

        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,

                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        bufnr = bufnr,
                        filter = function(client)
                            return true
                        end,
                    })
                end,
            })
        end
    end,
})
