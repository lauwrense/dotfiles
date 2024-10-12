---@type LanguagePlugin
return {
    spec = {},
    lsp = {
        {
            name = "zls",
            setup = function(server_name)
                vim.g.zig_fmt_autosave = 0
                require("lspconfig").zls.setup({
                    autotstart = false,
                    capabilities = require("plugins.lang.default").make_capabilities(),
                })
            end,
            autoinstall = false,
        },
    },
}
