return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        name = "treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "zig",
                "rust",

                "comment",

                "toml",
                "yaml",

                "rst",
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

                -- Latex
                "latex",

                -- Git
                "diff",
                "gitcommit",
                "gitattributes",
                "gitignore",
                "git_rebase",
                "git_config",
            },
            auto_install = true,
            highlight = {
                enable = true,
                disable = function(_, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats =
                        pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))

                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
                additional_vim_regex_highlighting = false,
            },
            ident = {
                enable = true
            },
        },
        config = function(self, opts)
            -- Dont remove this
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
