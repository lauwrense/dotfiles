vim.pack.add({
    { src = "https://codeberg.org/mfussenegger/nvim-dap" },
    { src = "https://github.com/Jorenar/nvim-dap-disasm" },
    { src = "https://github.com/igorlfs/nvim-dap-view" },
}, { confirm = false })


vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        if not package.loaded.dap then
            return
        end

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
    end
})
