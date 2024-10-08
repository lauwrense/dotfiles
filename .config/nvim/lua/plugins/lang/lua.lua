---@type LanguagePlugin
return {
    spec = {
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    "luvit-meta/library",
                    "~/projects/navy",
                },
            },
        },
        { "Bilal2453/luvit-meta", lazy = true },
        { "hrsh7th/cmp-nvim-lsp", ft = "lua" },
    },
    lsp = {
        ["lua_ls"] = {
            setup = function(server_name)
                local cmp = require("cmp")

                local sources = cmp.get_config().sources or {}

                local group =
                    vim.api.nvim_create_augroup("setup_cmp_sources_lua", {})
                vim.api.nvim_create_autocmd(
                    { "BufRead", "BufNew", "FileType" },
                    {
                        pattern = "*.lua",
                        group = group,
                        callback = function(ev)
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

                require("lspconfig")["lua_ls"].setup({
                    settings = {
                        Lua = {
                            telemetry = {
                                enable = false,
                            },
                        },
                    },
                    capabilities = require("plugins.lang.default").make_capabilities(),
                })
            end,
        },
    },
}
