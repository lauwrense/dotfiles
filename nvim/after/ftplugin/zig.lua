vim.opt_local.colorcolumn = "100"

local dap = require("dap")
local lldb_dap = vim.fn.exepath("lldb-dap")
if lldb_dap ~= "" then
    dap.configurations.zig = {
        {
            name = "Launch",
            type = "lldb",
            request = "launch",
            program = function()
                local path = vim.fn.getcwd()
                    .. "/zig-out/bin/"
                    .. vim.fs.basename(vim.fn.getcwd())
                if not vim.uv.fs_stat(path) then
                    vim.ui.input({ prompt = "zig build " }, function(args)
                        vim.cmd.make(args)
                    end)
                end

                return not vim.uv.fs_stat(path) and dap.ABORT or path
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},
        },
    }
end
