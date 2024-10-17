local lsp = {
    name = "gopls",
    -- this is the mason name
    bin = "gopls",
}
local lspconfig = require("lspconfig")
local cmp = require("cmp")
local sources = cmp.get_config().sources or {}

local registry = require("mason-registry")
local pkg = registry.get_package(lsp.bin)
pkg:install()

if not pkg:is_installed() and vim.fn.exepath(lsp.bin) == "" then
    pkg:install()
    pkg:on("install:success", function ()
        lspconfig[lsp.name].setup({})
    end)
else
    lspconfig[lsp.name].setup({})
end

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


if not pkg:is_installed() and vim.fn.exepath(lsp.bin) == "" then
    pkg:install()
    pkg:on("install:success", function ()
        lspconfig[lsp.name].setup({})
    end)
else
    lspconfig[lsp.name].setup({})
end
