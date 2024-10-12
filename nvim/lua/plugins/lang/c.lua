---@type LanguagePlugin
return {
    spec = {},
    lsp = {
        {
            name = "neocmake",
            setup = function(_)
                require("lspconfig")["neocmake"].setup({
                    capabilities = require("plugins.lang.default").make_capabilities(),
                })
            end,
        },
    },
}
