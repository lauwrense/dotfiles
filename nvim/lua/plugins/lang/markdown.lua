---@type LanguagePlugin
return {
    spec = {},
    lsp = {
        {
            name = "marksman",
            cmp_enabled = true,
            setup = function()
                require("lspconfig")["marksman"].setup({
                    capabilities = require("plugins.lang.default").make_capabilities(),
                })
            end,
        },
    },
}
