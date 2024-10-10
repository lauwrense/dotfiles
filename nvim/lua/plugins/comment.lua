return {
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = "VeryLazy",
        opts = {
            enable_autocmd = false,
        },
    },
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function()
            ---@diagnostic disable-next-line:missing-fields
            require("Comment").setup({
                pre_hook = require(
                    "ts_context_commentstring.integrations.comment_nvim"
                ).create_pre_hook(),
            })
        end,
    },
}
