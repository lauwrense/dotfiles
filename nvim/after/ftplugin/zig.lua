vim.g.zig_fmt_autosave = 0
vim.opt_local.colorcolumn = "100"

local dap = require("dap")
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
