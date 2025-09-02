return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = "main",
        build = function()
            local parser_installed = {
                "zig",

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
            local avalable = ts.get_available()
            local installed = ts.get_installed()

            local function setup_treesitter()
                vim.wo.foldexpr = vim.wo.foldexpr
                    or "v:lua.vim.treesitter.foldexpr()"
                vim.schedule(function()
                    vim.treesitter.start()
                end)
            end

            vim.api.nvim_create_autocmd(
                { "BufReadPost", "BufNewFile", "FileType" },
                {
                    group = treesitter_group,
                    buffer = 0,
                    callback = function(args)
                        local ft = vim.bo[args.buf].filetype
                        local lang = vim.treesitter.language.get_lang(ft)

                        if vim.list_contains(installed, lang) then
                            setup_treesitter()
                        elseif vim.list_contains(avalable, lang) then
                            ts.install(lang):await(setup_treesitter)
                            installed = ts.get_installed()
                        end
                    end,
                }
            )
        end,
    },
}
