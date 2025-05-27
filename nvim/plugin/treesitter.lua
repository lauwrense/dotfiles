local function ts_shutdown_on_max_size(buffer, fname, max_fsize)
    local augroup = vim.api.nvim_create_augroup("TSShutdownOnMaxFile", {})
    vim.api.nvim_create_autocmd("BufWrite", {
        buffer = buffer,
        group = augroup,
        callback = function()
            local ok, stat = pcall(vim.uv.fs_stat, fname)

            if ok and stat and stat.size > 1024 * max_fsize then
                vim.treesitter.stop()
            end
        end,
    })
end

--- Highlight
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        local max_size = 100
        local buf = vim.api.nvim_get_current_buf()
        local fname = vim.api.nvim_buf_get_name(buf)
        local ok, stat = pcall(vim.uv.fs_stat, fname)

        if ok and stat and stat.size > 1024 * max_size then
            return
        end

        if vim.treesitter.language.add(vim.bo.filetype) then
            vim.treesitter.start()
            ts_shutdown_on_max_size(buf, fname, max_size)
        end
    end,
})
