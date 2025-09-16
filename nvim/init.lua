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
    {
        src = "https://github.com/catppuccin/nvim",
        name = "catppuccin",
    },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/kylechui/nvim-surround" },
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "main",
    },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/sindrets/diffview.nvim" },
    { src = "https://codeberg.org/mfussenegger/nvim-dap" },
    { src = "https://github.com/Jorenar/nvim-dap-disasm" },
    { src = "https://github.com/igorlfs/nvim-dap-view" },
}, { confirm = false })

require("catppuccin").setup({
    integrations = {
        native_lsp = {
            underlines = {
                errors = { "undercurl" },
                hints = { "undercurl" },
                warnings = { "undercurl" },
                information = { "undercurl" },
                ok = { "undercurl" },
            },
        },
    },
})
vim.cmd.colorscheme("catppuccin-frappe")

vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
require("mason").setup()
require("nvim-surround").setup()

local ts = require("nvim-treesitter")
ts.install({
    "zig",

    -- Git
    "diff",
    "gitcommit",
    "gitattributes",
    "gitignore",
    "git_rebase",
    "git_config",
})
ts.update()

local avalable = ts.get_available()
local installed = ts.get_installed()

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "FileType" }, {
    group = vim.api.nvim_create_augroup("user.treesitter", {}),
    buffer = 0,
    callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)

        if lang == nil then
            return
        end

        local function setup_treesitter()
            vim.wo.foldexpr = vim.wo.foldexpr or "v:lua.vim.treesitter.foldexpr()"
            vim.schedule(function()
                vim.treesitter.start()
            end)
        end
        if vim.list_contains(installed, lang) then
            setup_treesitter()
        elseif vim.list_contains(avalable, lang) then
            ts.install(lang):await(setup_treesitter)
            installed = ts.get_installed()
        end
    end,
})
