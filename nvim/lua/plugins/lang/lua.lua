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
        {
            name = "lua_ls",
            cmp_enabled = true,
            setup = function(_)
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
    fmt = {"stylua"},
}
