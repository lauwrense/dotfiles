return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        name = "treesitter",
        branch = "main",
        build = function()
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
        init = function()
            -- Highlight
            local treesitter_group =
                vim.api.nvim_create_augroup("user.treesitter", {})
            local ts = require("nvim-treesitter")

            vim.api.nvim_create_autocmd("FileType", {
                group = treesitter_group,
                callback = function(args)
                    local ft = args.match
                    local lang = vim.treesitter.language.get_lang(ft)
                    local avalable = ts.get_available()

                    if vim.tbl_contains(avalable, lang) then
                        ts.install(lang):await(function()
                            vim.bo.indentexpr =
                                "v:lua.require'nvim-treesitter'.indentexpr()"
                            vim.wo.foldexpr = vim.wo.foldexpr
                                or "v:lua.vim.treesitter.foldexpr()"
                            vim.treesitter.start()
                        end)
                    end
                end,
            })
        end,
    },
}
