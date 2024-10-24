local lsp = {
    name = "neocmakelsp",
    -- this is the mason name
    bin = "neocmakelsp",
}
local lspconfig = require("lspconfig")
local util = require("custom.util")

util.find_or_install(lsp.bin, function ()
    lspconfig[lsp.name].setup({})
end)

util.enable_lsp_cmps()
