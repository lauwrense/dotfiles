vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
    rocks = {
        enabled = false,
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

--Dont load everything
if os.getenv("NVIM") ~= nil then
    require("lazy").setup({
        { "willothy/flatten.nvim", config = true },
    })
else
    require("lazy").setup("plugins", lazy_config)
    vim.cmd.colorscheme("catppuccin-frappe")
end
