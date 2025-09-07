
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.signcolumn = "yes:1"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.list = true
vim.opt.listchars = {
    tab = "> ",
    trail = "•",
    extends = "›",
    precedes = "‹",
}

vim.opt.mouse = ""
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
vim.opt.wrap = false
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.pumheight = 10

vim.opt.showmode = false

vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.updatetime = 200
vim.opt.path:append("**")

vim.opt.fillchars = [[eob: ,fold: ]]
vim.opt.laststatus = 3

vim.wo.foldtext = ""

vim.lsp.enable({ "clangd", "lua_ls", "zls" })

--- Lazy plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

---@type LazyConfig
local lazy_config = {
    install = {
        colorscheme = { "catppuccin-frappe" },
    },
    change_detection = {
        notify = false,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "netrwPlugin",
            },
        },
    },
}

require("lazy").setup("plugins", lazy_config)
vim.cmd.colorscheme("catppuccin-frappe")

