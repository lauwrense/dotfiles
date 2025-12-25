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

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineOk", { undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true })

vim.lsp.enable({ "lua_ls", "zls" })

vim.cmd.packadd("cfilter")

vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/kylechui/nvim-surround" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "main",
    },
    { src = "https://codeberg.org/mfussenegger/nvim-dap" },
    { src = "https://github.com/Jorenar/nvim-dap-disasm" },
    { src = "https://github.com/igorlfs/nvim-dap-view" },
    { src = "https://github.com/windwp/nvim-autopairs" },
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

require("nvim-autopairs").setup({ map_cr = true })

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
