---@class LanguagePlugin
---@field spec LazySpec
---@field cmp (fun(): cmp.ConfigSchema)?
---@field lsp table<string, LanguagePluginLSP>? A table of lsp names
---@field dap fun()?
---@field test fun()?

---@class DefaultLanguagePlugin : LanguagePlugin
---@field lsp fun(server_name: string?)
---@field make_capabilities fun(): lsp.ClientCapabilities

---@class LanguagePluginLSP
---@field setup fun(server_name: string)
---@field automatic_install boolean? default: true

---@alias LanguagePluginSpecName
---| "spec"
---| "cmp"
---| "lsp"
---| "dap"
---| "fmt"
---| "test"

local function make_capabilities()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }

    return capabilities
end

---@type DefaultLanguagePlugin
return {
    spec = {},
    dap = function() end,
    make_capabilities = make_capabilities,
    lsp = function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = make_capabilities(),
        })
    end
}
