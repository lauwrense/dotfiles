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
require("mason").setup()

require("gitsigns").setup({
    attach_to_untracked = true,
    on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
            if vim.wo.diff then
                vim.cmd.normal({ "]c", bang = true })
            else
                gitsigns.nav_hunk("next")
            end
        end)

        map("n", "[c", function()
            if vim.wo.diff then
                vim.cmd.normal({ "[c", bang = true })
            else
                gitsigns.nav_hunk("prev")
            end
        end)

        -- Actions
        map("n", "<leader>hs", gitsigns.stage_hunk)
        map("n", "<leader>hr", gitsigns.reset_hunk)

        map("v", "<leader>hs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)

        map("v", "<leader>hr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)

        map("n", "<leader>hS", gitsigns.stage_buffer)
        map("n", "<leader>hR", gitsigns.reset_buffer)
        map("n", "<leader>hp", gitsigns.preview_hunk)
        map("n", "<leader>hi", gitsigns.preview_hunk_inline)

        map("n", "<leader>hb", function()
            gitsigns.blame_line({ full = true })
        end)

        map("n", "<leader>hd", gitsigns.diffthis)

        map("n", "<leader>hD", function()
            gitsigns.diffthis("~")
        end)

        map("n", "<leader>hQ", function()
            gitsigns.setqflist("all")
        end)
        map("n", "<leader>hq", gitsigns.setqflist)

        -- Toggles
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
        map("n", "<leader>tw", gitsigns.toggle_word_diff)

        -- Text object
        map({ "o", "x" }, "ih", gitsigns.select_hunk)
    end,
})

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
