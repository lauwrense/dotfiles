vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank({ higroup = "Visual" })
    end,
})

--- BIG FILE
local max_fsize = 2 * 1024 * 1024 -- 2 MiB

local shutdown_group = vim.api.nvim_create_augroup("user.bigfile.shutdown", {})
vim.api.nvim_create_autocmd({ "BufReadPost", }, {
    group = shutdown_group,
    callback = function(args)
        local ok, file = pcall(vim.uv.fs_stat, args.file)

        if not ok or file and file.size > max_fsize then
            vim.treesitter.stop(args.buf)
            return
        end
    end,
})

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
    group = shutdown_group,
    callback = function(args)
        local ok, file = pcall(vim.uv.fs_stat, args.file)

        if not ok or file and file.size > max_fsize then
            vim.lsp.buf_detach_client(args.buf, args.data.client_id)
            return
        end

        vim.lsp.completion.enable(true, args.data.client_id, args.buf)
    end,
})
