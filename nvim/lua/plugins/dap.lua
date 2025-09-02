return {
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        dependencies = {
            "Jorenar/nvim-dap-disasm",
            "igorlfs/nvim-dap-view",
        },
        config = function()
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
        end,
    },
    {
        "Jorenar/nvim-dap-disasm",
        lazy = true,
        dependencies = { "igorlfs/nvim-dap-view" },
        config = true,
    },
    {
        "igorlfs/nvim-dap-view",
        lazy = true,
        opts = {
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
            windows = {
                position = "right",
                terminal = {
                    position = "below"
                }
            }
        },
    },
}
