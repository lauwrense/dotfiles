return {
    {
        "stevearc/oil.nvim",
        keys = {
            { "<leader>O", "<cmd>Oil<cr>", desc = "Oiling up" },
        },
        config = function()
            require("oil").setup({
                columns = {
                    "icon",
                    "permissions",
                    "size",
                    "mtime",
                },
            })
        end,
    },
}
