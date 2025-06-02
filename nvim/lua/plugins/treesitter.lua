return {
    {
        "nvim-treesitter/nvim-treesitter",
        name = "treesitter",
        branch = "main",
        build = ":TSUpdate",
        lazy = false,
        config = function()
            require("nvim-treesitter").install({
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
            })
        end,
    },
}
