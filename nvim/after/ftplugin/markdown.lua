local lsp = {
    name = "marksman",
    -- this is the mason name
    bin = "marksman",
}
local lspconfig = require("lspconfig")
local util = require("custom.util")

util.find_or_install(lsp.bin, function ()
    lspconfig[lsp.name].setup({})
end)

util.enable_lsp_cmps()
