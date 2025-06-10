-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client and client:supports_method("textDocument/foldingRange") then
            vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
        end
    end,
})

-- Fallback
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        vim.wo.foldexpr = vim.wo.foldexpr or "indent"
    end,
})

vim.wo.foldtext = ""
