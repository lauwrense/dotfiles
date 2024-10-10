---@type LanguagePlugin
return {
    spec = {
        {
            "OXY2DEV/markview.nvim",
            ft = "md",
            dependencies = {
                "nvim-treesitter/nvim-treesitter",
                "nvim-tree/nvim-web-devicons",
            },
            opts = {},
        },
    },
    lsp = {
        ["marksman"] = {
            setup = function(server_name)
                local cmp = require("cmp")

                local sources = require("cmp").get_config().sources or {}

                local group = vim.api.nvim_create_augroup(
                    "setup_cmp_sources_markdown",
                    {}
                )
                vim.api.nvim_create_autocmd(
                    { "BufRead", "BufNew", "FileType" },
                    {
                        pattern = { "*.md" },
                        group = group,
                        callback = function()
                            if
                                not vim.iter(sources):any(function(value)
                                    return value.name == "nvim_lsp"
                                end)
                            then
                                sources[#sources + 1] = { name = "nvim_lsp" }
                            end

                            cmp.setup.buffer({ sources = sources })
                        end,
                    }
                )
                require("lspconfig")["marksman"].setup({
                    capabilities = require("plugins.lang.default").make_capabilities(),
                })
            end,
        },
    },
}
