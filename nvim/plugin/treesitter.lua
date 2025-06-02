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

        local exists, lang =
            pcall(vim.treesitter.language.get_lang, vim.bo.filetype)

        if not exists then
            return
        elseif package.loaded["nvim-treesitter"] then
            require("nvim-treesitter").install(lang)
        end

        if lang and vim.treesitter.language.add(lang) then
            vim.treesitter.start()

            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo.foldtext = ""

            ts_shutdown_on_max_size(buf, fname, max_size)
        end
    end,
})
