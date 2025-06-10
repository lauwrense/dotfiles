return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        name = "treesitter",
        branch = "main",
        build = {
            function()
                local parser_installed = {
                    "zig",

                    -- Go
                    "go",
                    "gosum",
                    "gomod",
                    "gowork",

                    -- Scripting
                    "lua",
                    "luap",
                    "luadoc",

                    "python",

                    -- C
                    "doxygen",
                    "c",
                    "cpp",
                    "make",
                    "cmake",

                    -- MD
                    "markdown",
                    "markdown_inline",

                    -- Git
                    "diff",
                    "gitcommit",
                    "gitattributes",
                    "gitignore",
                    "git_rebase",
                    "git_config",
                }

                require("nvim-treesitter").install(parser_installed)
                require("nvim-treesitter").update()
            end,
            ":TSUpdate",
        },
    },
}
