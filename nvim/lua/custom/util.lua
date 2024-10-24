local M = {}

local cmp = nil
local sources = nil

M.find_or_install = function(name, callback)
    local registry = require("mason-registry")
    local pkg = registry.get_package(name)

    if not pkg:is_installed() and (vim.fn.exepath(name) == "") then
        pkg:install()
        pkg:on("install:success", vim.schedule_wrap(callback))
    else
        callback()
    end
end

M.enable_lsp_cmps = function ()
    cmp = cmp or require("cmp")
    sources = sources or cmp.get_config().sources or {}

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
end

return M
