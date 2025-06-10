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
        init = function()
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

            -- Highlight
            local treesitter_group =
                vim.api.nvim_create_augroup("user.treesitter.start", {})

            vim.api.nvim_create_autocmd("FileType", {
                group = treesitter_group,
                callback = function(args)
                    local ft = vim.bo[args.buf].filetype
                    local lang = vim.treesitter.language.get_lang(ft)

                    if lang == nil then
                        return
                    end

                    require("nvim-treesitter").install(lang)

                    if vim.treesitter.language.add(lang) then
                        vim.treesitter.start()
                    end
                end,
            })
        end,
    },
}
