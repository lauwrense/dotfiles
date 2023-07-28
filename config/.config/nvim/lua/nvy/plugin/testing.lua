return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            {
                "nvim-lua/plenary.nvim",
                config = function(plugin)
                    vim.opt.rtp:append(plugin.dir .. "/plugin/plenary.vim")
                end
            },
            "nvim-neotest/neotest-plenary"
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-plenary"),
                },
            })
        end
    },
}
