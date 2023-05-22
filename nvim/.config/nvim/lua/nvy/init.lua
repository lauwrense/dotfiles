require("nvy.config.settings")
require("nvy.config.keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

local lazy_config = {
    install = {
        colorscheme = {},
    },
    performance = {
        rtp = {
            disabled_plugins = {
                -- "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                -- "tarPlugin",
                "tohtml",
                "tutor",
                -- "zipPlugin",
            },
        },
    },
}

require("lazy").setup({
    { import = "nvy.plugin" },
    { import = "nvy.plugin.lsp" },
    { import = "nvy.plugin.lsp.ft" },
    { import = "nvy.plugin.completion" },
}, lazy_config)
