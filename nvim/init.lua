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
    { src = "https://github.com/kylechui/nvim-surround" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "main",
    },
    { src = "https://github.com/sindrets/diffview.nvim" },
    { src = "https://codeberg.org/mfussenegger/nvim-dap" },
    { src = "https://github.com/Jorenar/nvim-dap-disasm" },
    { src = "https://github.com/igorlfs/nvim-dap-view" },
}, { confirm = false })

require("catppuccin").setup({
    lsp_styles = {
        underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
            ok = { "undercurl" },
        },
    },
})
vim.cmd.colorscheme("catppuccin-frappe")

vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
require("nvim-surround").setup()

local dap = require("dap")

vim.keymap.set("n", "<F1>", function()
    dap.continue()
end)
vim.keymap.set("n", "<F2>", function()
    dap.step_over()
end)

vim.keymap.set("n", "<F3>", function()
    dap.step_into()
end)
vim.keymap.set("n", "<F4>", function()
    dap.step_out()
end)
vim.keymap.set("n", "<F5>", function()
    require("dap-view").toggle()
end)
vim.keymap.set("n", "<M-b>", function()
    dap.toggle_breakpoint()
end)

require("dap-view").setup({
    winbar = {
        sections = {
            "watches",
            "scopes",
            "exceptions",
            "breakpoints",
            "threads",
            "repl",
            "disassembly",
        },
    },
})
require("dap-disasm").setup()

local ts = require("nvim-treesitter")
ts.install({ "zig" })
ts.update()
