vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

--- Highlight
local treesitter_group = vim.api.nvim_create_augroup("user.treesitter.start", {})
vim.api.nvim_create_autocmd("FileType", {
    group = treesitter_group,
    callback = function(args)
        local filetype = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(filetype)

        if not lang then
            return
        end

        require("nvim-treesitter").install(lang)

        if lang and vim.treesitter.language.add(lang) then
            vim.treesitter.start()
        end
    end,
})
