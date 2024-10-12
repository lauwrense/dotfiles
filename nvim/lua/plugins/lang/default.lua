---@class LanguagePlugin
---@field spec LazySpec[]
---@field lsp LanguagePluginLSP[]?
---@field dap fun()?
---@field test fun()?
---@field lint fun()?
---@field fmt nil | string[] | string

---@class LanguagePluginLSP
---@field name string
---@field setup fun(server_name: string)
---@field cmp_enabled boolean? default: false if cmp sources are enabled
---@field automatic_install boolean? default: true

---@alias LanguagePluginSpecName
---| "spec"
---| "lsp"
---| "dap"
---| "test"
---| "lint"
---| "fmt"

local function make_capabilities()
    ---@type lsp.ClientCapabilities
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    capabilities.textDocument = {
        foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        },
    }

    return capabilities
end

return {
    ---@type LazySpec
    spec = {},
    ---@type fun(): lsp.ClientCapabilities
    make_capabilities = make_capabilities,
    ---@param server_name string?
    lsp = function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = make_capabilities(),
        })
    end,
}
