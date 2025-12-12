if not vim.env.MASON then
    return
end

-- TODO: properly configure this
local dap = require("dap")

dap.adapters.lldb = {
    type = "executable",
    name = "lldb",
    command = vim.fn.expand("$MASON/bin/codelldb"),
}

dap.configurations.zig = {
    {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
            local path = vim.fn.getcwd()
                .. "/zig-out/bin/"
                .. vim.fs.basename(vim.fn.getcwd())

            vim.ui.input({ prompt = "zig build " }, function(args)
                if tostring(args):find("^test") then
                    path = vim.fs.find("test", {
                        limit = 1,
                        type = "file",
                        path = "./.zig-cache",
                    })[1]
                end
                vim.cmd.make(args)
            end)

            return not vim.uv.fs_stat(path) and dap.ABORT or path
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
    },
}
