return {
    {
        "folke/flash.nvim",
        opts = {
            modes = {
                search = {
                    highlight = {
                        backdrop = true,
                    },
                },
                char = {
                    jump_labels = true,
                },
            },
        },
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
            {
                "<c-s>",
                mode = { "c" },
                function()
                    require("flash").toggle()
                end,
                desc = "Toggle Flash Search",
            },
        },
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = { "VeryLazy" },
        keys = {
            { "ys" },
            { "yss" },
            { "yS" },
            { "ySS" },
            { "S", mode = "v" },
            { "gS", mode = "v" },
            { "ds" },
            { "cs" },
            { "cS" },
        },
        config = true,
    },
}
