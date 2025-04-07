return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
            local dap = require("dap")

            local lldb_dap = vim.fn.exepath("lldb-dap")
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
                dap.configurations.zig = {
                    {
                        name = "Launch",
                        type = "lldb",
                        request = "launch",
                        program = "${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}",
                        cwd = "${workspaceFolder}",
                        stopOnEntry = false,
                        args = {},
                    },
                }
            end
        end,
    },
}
