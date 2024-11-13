local M = {}

local cmp = require("cmp")
local sources = cmp.get_config().sources or {}

M.enable_lsp_cmp = function()
    local new_sources = { { name = "nvim_lsp" } }
    if
        not vim.iter(sources):any(function(value)
            return value.name == "nvim_lsp"
        end)
    then
        vim.list_extend(new_sources, sources)
    end

    cmp.setup.buffer({ sources = new_sources })
end

M.disable_lsp_cmp = function()
    local new_sources = vim.iter(sources)
        :filter(function(value)
            return value.name ~= "nvim_lsp"
        end)
        :totable()

    cmp.setup.buffer({ sources = new_sources })
end

M.toggle_lsp_cmp = function()
    local new_sources = { { name = "nvim_lsp" } }
    if
        not vim.iter(sources):any(function(value)
            return value.name == "nvim_lsp"
        end)
    then
        vim.list_extend(new_sources, sources)
    else
        new_sources = vim.iter(sources)
            :filter(function(value)
                return value.name ~= "nvim_lsp"
            end)
            :totable()
    end

    cmp.setup.buffer({ sources = new_sources })
end

M.lsp_on_attach = function ()
    vim.diagnostic.setqflist()
    vim.lsp.buf.definition()
    vim.lsp.buf.references()
    vim.lsp.buf.type_definition()
    vim.lsp.buf.implementation()


end

return M
