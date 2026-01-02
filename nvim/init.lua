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

vim.lsp.enable({ "lua_ls", "zls" })

vim.cmd.packadd("cfilter")

vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/kylechui/nvim-surround" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://codeberg.org/mfussenegger/nvim-dap" },
    { src = "https://github.com/Jorenar/nvim-dap-disasm" },
    { src = "https://github.com/igorlfs/nvim-dap-view" },
    { src = "https://github.com/Wansmer/treesj" },
    { src = "https://github.com/stevearc/oil.nvim" },
    {
        src = "https://github.com/catppuccin/nvim",
        name = "catppuccin",
    },
}, { confirm = false })

require("conform").setup({
    formatters_by_ft = {
        markdown = { "mdformat" },
        lua = { "stylua" },
        zig = { "zigfmt" },
    },
    default_format_opts = {
        lsp_format = "fallback",
    },
})
vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"

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
vim.cmd.colorschem("catppuccin-frappe")

require("oil").setup({
    columns = { "icon", "permissions", "size", "mtime" },
    keymaps = {
        ["<leader>o"] = { "actions.close", mode = "n" },
    },
})
vim.keymap.set("n", "<leader>o", require("oil").open)

vim.keymap.set("n", "<leader>m", require("treesj").toggle)
vim.keymap.set("n", "<leader>M", function()
    require("treesj").toggle({ split = { recursive = true } })
end)

require("nvim-surround").setup()

local dap = require("dap")
local dap_view = require("dap-view")

vim.keymap.set("n", "<M-b>", dap.toggle_breakpoint)
vim.keymap.set("n", "<F1>", dap.continue)
vim.keymap.set("n", "<F2>", dap.step_over)
vim.keymap.set("n", "<F3>", dap.step_into)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<F5>", dap_view.toggle)

dap_view.setup({
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
