local lsp = {
    name = "lua_ls",
    -- this is the mason name
    bin = "lua-language-server",
}
local lspconfig = require("lspconfig")
local cmp = require("cmp")
local sources = cmp.get_config().sources or {}

local registry = require("mason-registry")
local pkg = registry.get_package(lsp.bin)

if ok then
    pkg:install()
end

require("lspconfig")[lsp.name].setup({})

if
    not vim.iter(sources):any(function(value)
        return value.name == "nvim_lsp"
    end)
then
    local new_sources = { { name = "nvim_lsp" } }
    vim.list_extend(new_sources, sources)
    sources = new_sources
end

cmp.setup.buffer({ sources = sources })
