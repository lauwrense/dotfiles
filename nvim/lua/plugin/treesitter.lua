local M = {}

vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
}, { confirm = false })

local ts = require("nvim-treesitter")

local available_ts = nil
local installed_ts = nil

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "FileType" }, {
    group = vim.api.nvim_create_augroup("user.treesitter", {}),
    buffer = 0,
    callback = function(args)
        local ts = require("nvim-treesitter")
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)

        if lang == nil then
            return
        end

        available_ts = available_ts or ts.get_available()
        installed_ts = installed_ts or ts.get_installed()

        local function setup_treesitter()
            vim.wo.foldexpr = vim.wo.foldexpr
                or "v:lua.vim.treesitter.foldexpr()"
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            vim.schedule(function()
                vim.treesitter.start()
            end)
        end

        if vim.list_contains(installed_ts, lang) then
            setup_treesitter()
        elseif vim.list_contains(available_ts, lang) then
            ts.install(lang):await(setup_treesitter)
            installed_ts = ts.get_installed()
        end
    end,
})

M.install = function(args)
    ts.install(args)
    ts.update()
end

return M
