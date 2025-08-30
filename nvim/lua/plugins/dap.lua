return {
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        dependencies = {
            "nvim-neotest/nvim-nio",
            "rcarriga/nvim-dap-ui",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

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
                dapui.toggle()
            end)
            vim.keymap.set("n", "<M-b>", function()
                dap.toggle_breakpoint()
            end)

            dapui.setup()

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },
}
