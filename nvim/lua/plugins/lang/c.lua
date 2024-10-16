---@type LanguagePlugin
return {
    spec = {},
    lsp = {
        {
            name = "neocmake",
            cmp_enabled = true,
            setup = function()
                require("lspconfig")["neocmake"].setup({
                    capabilities = require("plugins.lang.default").make_capabilities(),
                })
            end,
        },
    },
}
