return {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        -- Adapters
        "lawrence-laz/neotest-zig",
        "fredrikaverpil/neotest-golang",
    },
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("neotest").setup({
            adapters = {
                require("neotest-golang"),
                require("neotest-zig")({
                    dap = {
                        adapter = "lldb",
                    },
                }),
            },
        })
    end,
}
