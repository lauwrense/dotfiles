---@type LanguagePlugin
return {
    spec = {},
    lsp = {
        {
            name = "marksman",
            setup = function(server_name)
                require("lspconfig")["marksman"].setup({
                    capabilities = require("plugins.lang.default").make_capabilities(),
                })
            end,
        },
    },
}
