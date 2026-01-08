vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes:1"

vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1

vim.opt.completeopt = "menu,popup,noinsert,noselect"
vim.opt.wildmode = "longest,noselect"

vim.opt.wildignorecase = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.list = true

vim.opt.mouse = ""
vim.opt.wrap = false

vim.opt.pumheight = 10
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.path:append("**")
vim.opt.laststatus = 3

vim.cmd.packadd("cfilter")

vim.lsp.enable({ "lua_ls", "zls" })
--- Core plugins should always be installed
vim.pack.add({
    { src = "https://github.com/kylechui/nvim-surround" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
}, { confirm = false })

--- Comment out line to disable them
require("plugin.conform")
require("plugin.git")
require("plugin.treesitter").install({"zig"})
require("plugin.dap")

require("plugin.oil")
require("plugin.motions")

--- Colorscheme
require("plugin.catppuccin")
vim.cmd.colorschem("catppuccin-frappe")
