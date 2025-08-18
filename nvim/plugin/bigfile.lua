local max_fsize = 2 * 1024 * 1024 -- 2 MiB

local shutdown_group = vim.api.nvim_create_augroup("user.bigfile.shutdown", {})
vim.api.nvim_create_autocmd({ "BufReadPost", "UIEnter" }, {
    group = shutdown_group,
    callback = function(args)
        local ok, file = pcall(vim.uv.fs_stat,args.file)

        if not ok or file and file.size < max_fsize then
            return
        end

        -- Treesitter
        if vim.treesitter.highlighter.active[args.buf] then
            vim.treesitter.stop(args.buf)
        end
    end,
})

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
    group = shutdown_group,
    callback = function(args)
        local ok, file = pcall(vim.uv.fs_stat,args.file)

        if not ok or file and file.size < max_fsize then
            return
        end
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client then
            client:stop(true)
        end
    end,
})
