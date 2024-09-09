---@type LanguagePlugin
return {
    spec = {
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    "luvit-meta/library",
                },
            },
        },
        { "Bilal2453/luvit-meta", lazy = true },
    },
    lsp = {
        ["lua_ls"] = {
            setup = function(server_name)
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
        }
    },
}
