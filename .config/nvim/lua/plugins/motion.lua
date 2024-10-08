return {
    {
        "m4xshen/hardtime.nvim",
        opts = {
            max_count = 1,
            notification = false,
            allow_different_key = true,
            hint = true,
            disabled_filetypes = {
                "qf",
                "netrw",
                "NvimTree",
                "lazy",
                "mason",
                "NeogitStatus",
                "crates.nvim",
            },
        },
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
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
                "S",
                mode = { "n", "x", "o" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "R",
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
        event = "VeryLazy",
        config = true,
    },
}
