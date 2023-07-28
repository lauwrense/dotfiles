return {
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup({
                padding = true,
                sticky = true,
                toggler = {
                    line = "gcc",
                    block = "gbc",
                },
                opleader = {
                    line = "gc",
                    block = "gb",
                },
                extra = {
                    above = "<nop>",
                    below = "<nop>",
                    eol = "gcA",
                },
                mappings = {
                    basic = true,
                    extra = true,
                },
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
                post_hook = function() end,
            })
        end,
    },
}
