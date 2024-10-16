---@type LanguagePlugin
return {
    spec = {},
    lsp = {
        {
            name = "gopls",
            setup = function()
                require("lspconfig")["gopls"].setup({
                    capabilities = require("plugins.lang.default").make_capabilities()
                })
            end
        },
    },
    fmt = { "goimports-reviser", "golines"},
}
