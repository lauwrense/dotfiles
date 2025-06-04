local max_fsize = 2 * 1024 * 1024 -- 2 MiB

local shutdown_group = vim.api.nvim_create_augroup("user.bigfile.shutdown", {})
vim.api.nvim_create_autocmd({ "BufReadPost", "UIEnter" }, {
    group = shutdown_group,
    callback = function(args)
        local ok, stat = pcall(vim.uv.fs_stat, args.file)

        if not ok or not stat or stat.size < max_fsize then
            return
        end

        -- Treesitter
        if vim.treesitter.highlighter.active[args.buf] then
            vim.treesitter.stop(args.buf)
        end

        -- LSP
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(a)
                local client = vim.lsp.get_client_by_id(a.data.client_id)

                if client then
                    client:stop(true)
                end
            end,
        })

        -- Rainbow Delimeters
        require("rainbow-delimiters").disable(args.buf)
    end,
})
