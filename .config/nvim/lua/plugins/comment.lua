return {
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        events = "VeryLazy",
        opts = {
            enable_autocmd = false,
        },
    },
    {
        "numToStr/Comment.nvim",
        events = "VeryLazy",
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
