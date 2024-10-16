---@class LanguagePlugin
---@field spec LazySpec[]
---@field lsp LanguagePluginLSP[]?
---@field dap fun()?
---@field test fun()?
---@field lint LanguagePluginLint[]?
---@field fmt LanguagePluginFmt[]?

---@class LanguagePluginLSP
---@field name string
---@field setup fun(server_name: string?) | fun()
---@field cmp_enabled boolean? default: false if cmp sources are enabled
---@field automatic_install boolean? default: true

---@alias LanguagePluginFmt LanguagePluginFmtBase | string
---@class LanguagePluginFmtBase
---@field [1] string
---@field automatic_install boolean? default: true

---@alias LanguagePluginLint LanguagePluginLintBase | string
---@class LanguagePluginLintBase
---@field [1] string
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
    return require("cmp_nvim_lsp").default_capabilities()
end

return {
    ---@type fun(): lsp.ClientCapabilities
    make_capabilities = make_capabilities,
    ---@param server_name string?
    lsp = function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = make_capabilities(),
        })
    end,
}
