local lsp = {
    name = "lua_ls",
    -- this is the mason name
    bin = "lua-language-server",
}
local lspconfig = require("lspconfig")
local util = require("custom.util")

util.find_or_install(lsp.bin, function ()
    lspconfig[lsp.name].setup({})
end)

util.enable_lsp_cmps()
