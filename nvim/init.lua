vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes:1"

vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.list = true
vim.opt.listchars = {
    tab = "> ",
    trail = "•",
    extends = "›",
    precedes = "‹",
}

vim.opt.fillchars = {
    eob = " ",
    fold = " ",
}

vim.opt.mouse = ""
vim.opt.wrap = false

vim.opt.pumheight = 10
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.updatetime = 200
vim.opt.path:append("**")
vim.opt.laststatus = 3

vim.lsp.enable({ "clangd", "lua_ls", "zls" })

vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/kylechui/nvim-surround"},
}, { confirm = false })

vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
require("mason").setup()
require("nvim-surround").setup()

vim.cmd.colorscheme("habamax")

---@diagnostic disable-next-line: duplicate-set-field
require("editorconfig").properties.max_line_length = function (_, val)
    vim.wo.colorcolumn = val
end

-- Deprecation guard
-- Some plugins might not fully support nightly
if vim.version().prerelease == "dev" then
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.deprecate = function() end
else
    vim.deprecate("deprecate the deprecate guard for non dev builds")
end
