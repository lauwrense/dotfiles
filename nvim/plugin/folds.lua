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
        local exists, lang =
            pcall(vim.treesitter.language.get_lang, vim.bo.filetype)

        if not exists then
            return
        end

        if lang and vim.treesitter.language.add(lang) then
            vim.wo.foldexpr = vim.wo.foldexpr or "v:lua.vim.treesitter.foldexpr()"
        else
            vim.wo.foldexpr = vim.wo.foldexpr or "indent"
        end
    end,
})

vim.wo.foldtext = ""
