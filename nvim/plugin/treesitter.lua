vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

--- Highlight
local treesitter_group =
    vim.api.nvim_create_augroup("user.treesitter.start", {})
vim.api.nvim_create_autocmd("FileType", {
    group = treesitter_group,
    callback = function(args)
        local filetype = vim.bo[args.buf].filetype

        local ok, lang = pcall(vim.treesitter.language.get_lang, filetype)

        if not ok or not lang then
            return
        elseif package.loaded["nvim-treesitter"] then
            require("nvim-treesitter").install(lang)
        end

        if lang and vim.treesitter.language.add(lang) then
            vim.treesitter.start()
        end
    end,
})
