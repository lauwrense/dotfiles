return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "leoluz/nvim-dap-go",
        },
        ft = { "c", "cpp" },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            local lldb_dap = vim.fn.exepath("lldb-dap") -- PERF: WSL is slow
            if lldb_dap ~= "" then
                dap.adapters.lldb = {
                    type = "executable",
                    name = "lldb",
                    command = lldb_dap,
                }

                dap.configurations.cpp = {
                    {
                        name = "Launch",
                        type = "lldb",
                        request = "launch",
                        program = function()
                            return vim.fn.input(
                                "Path to executable: ",
                                vim.fn.getcwd() .. "/",
                                "file"
                            )
                        end,
                        cwd = "${workspaceFolder}",
                        stopOnEntry = false,
                        args = {},
                    },
                }

                dap.configurations.c = dap.configurations.cpp
            end

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
