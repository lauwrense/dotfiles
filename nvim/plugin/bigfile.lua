local max_fsize = 2 * 1024 * 1024 -- 2 MiB

local shutdown_group = vim.api.nvim_create_augroup("user.bigfile.shutdown", {})
vim.api.nvim_create_autocmd({ "BufReadPost", "UIEnter" }, {
    group = shutdown_group,
    callback = function(args)
        local size = vim.fn.getfsize(args.file)

        if size < max_fsize then
            return
        end

        -- Treesitter
        if vim.treesitter.highlighter.active[args.buf] then
            vim.treesitter.stop(args.buf)
        end

        -- Rainbow Delimeters
        require("rainbow-delimiters").disable(args.buf)
    end,
})

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local size = vim.fn.getfsize(args.file)

        if size < max_fsize then
            return
        end
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client then
            client:stop(true)
        end
    end,
})
