vim.pack.add({
    { src = "https://codeberg.org/mfussenegger/nvim-dap" },
    { src = "https://github.com/Jorenar/nvim-dap-disasm" },
    { src = "https://github.com/igorlfs/nvim-dap-view" },
}, { confirm = false })

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
