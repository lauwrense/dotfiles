return {
    {
        "nvim-treesitter/nvim-treesitter",
        name = "Treesitter",
        build = ":TSUpdate",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects" },
        },
        opts = {
            ensure_installed = {
                "zig",
                "rust",

                "comment",

                "toml",
                "yaml",

                "rst",
                -- Scripting
                "lua",
                "luap",
                "luadoc",

                "python",
                -- C
                "c",
                "cpp",
                "make",
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
            },
            highlight = {
                enable = true,
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats =
                        pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
                additional_vim_regex_highlighting = false,
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = {
                            query = "@class.inner",

                            desc = "Select inner part of a class region",
                        },
                        ["as"] = {
                            query = "@scope",
                            query_group = "locals",
                            desc = "Select language scope",
                        },

                    },
                    selection_modes = {
                        ["@parameter.outer"] = "v", -- charwise
                        ["@function.outer"] = "V", -- linewise
                        ["@class.outer"] = "<c-v>", -- blockwise
                    },
                    include_surrounding_whitespace = true,
                },
            },
        },
        config = true,
    },
}
