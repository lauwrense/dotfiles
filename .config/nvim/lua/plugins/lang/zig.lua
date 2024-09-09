---@type LanguagePlugin
return {
    spec = {},
    lsp = {
        ["zls"] = {
            setup = function(server_name)
                require("lspconfig").zls.setup({
                    capabilities = require("plugins.lang.default").make_capabilities(),
                })
            end,
            autoinstall = false,
        },
    },
}
