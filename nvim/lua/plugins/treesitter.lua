return {
    {
        "nvim-treesitter/nvim-treesitter",
        name = "treesitter",
        branch = "main",
        build = ":TSUpdate",
        lazy = false,
        init = function()
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
        config = function()
            local ensure_installed = {
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
            for _, lang in ipairs(ensure_installed) do
                if vim.treesitter.language.add(lang) ~= true then
                    require("nvim-treesitter").install(lang)
                end
            end
        end,
    },
}
