return {
    { "lewis6991/gitsigns.nvim", config = true },
    { "sindrets/diffview.nvim",  config = true },
    {
        "TimUntersberger/neogit",
        cmd = "Neogit",
        config = function()
            require("neogit").setup({
                integrations = {
                    diffview = true
                }
            })
        end
    },
    {
        "pwntester/octo.nvim",
        cmd = "Octo",
        config = true,
    },
}
