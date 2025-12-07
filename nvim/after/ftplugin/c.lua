vim.opt.colorcolumn = "80"

local dap = require("dap")

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
                local path = vim.fn.input({
                    prompt = "Path to executable: ",
                    default = vim.fn.getcwd() .. "/",
                    completion = "file",
                })

                return (path and path ~= "") and path or dap.ABORT
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},
        },
    }

    dap.configurations.c = dap.configurations.cpp
end
