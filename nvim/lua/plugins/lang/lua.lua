---@type LanguagePlugin
return {
    spec = {
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    { path = "luvit-meta/library", words = { "vim%.uv" } },
                },
            },
        },
        { "Bilal2453/luvit-meta", lazy = true },
    },
    lsp = {
        {
            name = "lua_ls",
            cmp_enabled = true,
            setup = function()
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
    fmt = { "stylua" },
}
