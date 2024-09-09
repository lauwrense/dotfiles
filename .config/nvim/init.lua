require("config.settings")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
                "matchparen",
                "netrwPlugin",
                -- "tarPlugin",
                "tohtml",
                "tutor",
                -- "zipPlugin",
            },
        },
    },
    ui = {
        backdrop = 100,
    },
}

if os.getenv("NVIM") ~= nil then
    require("lazy").setup({
        { "willothy/flatten.nvim", config = true },
    })
else
    require("lazy").setup("plugins", lazy_config)
    vim.cmd.colorscheme("catppuccin-frappe")
end
