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

local lazy_config = {
    install = {
        colorscheme = { "catppuccin-frappe" },
    },
    performance = {
        rtp = {
            disabled_plugins = {
                -- "gzip",
                "matchit",
                -- "matchparen",
                "netrwPlugin",
                -- "tarPlugin",
                "tohtml",
                "tutor",
                "fzf",
                -- "zipPlugin",
            },
        },
    },
}

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Dont load everything if env var 'NVIM' exist
if not vim.env.NVIM then
    require("lazy").setup("plugins", lazy_config)
    vim.cmd.colorscheme("catppuccin-frappe")
    vim.cmd.packadd("cfilter")
end
