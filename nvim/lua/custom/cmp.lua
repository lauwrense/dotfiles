local M = {}

M.enable_lsp_cmp = function()
    vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
        group = vim.api.nvim_create_augroup("EnableLSPCmp", {}),
        callback = function()
            local cmp = require("cmp")
            local sources = cmp.get_config().sources or {}
            local new_sources = { { name = "nvim_lsp" } }
            if
                not vim.iter(sources):any(function(value)
                    return value.name == "nvim_lsp"
                end)
            then
                vim.list_extend(new_sources, sources)
            end

            cmp.setup.buffer({ sources = new_sources })
        end,
    })

    vim.api.nvim_create_autocmd({"BufLeave"}, {
        group = vim.api.nvim_create_augroup("DisableLSPCmp", {}),
        callback = M.disable_lsp_cmp
    })
end

M.disable_lsp_cmp = function()
    local cmp = require("cmp")
    local sources = cmp.get_config().sources or {}
    local new_sources = vim.iter(sources)
        :filter(function(value)
            return value.name ~= "nvim_lsp"
        end)
        :totable()

    cmp.setup.buffer({ sources = new_sources })
end

M.toggle_lsp_cmp = function()
    vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
        group = vim.api.nvim_create_augroup("ToggleLSPCmp", {}),
        callback = function()
            local cmp = require("cmp")
            local sources = cmp.get_config().sources or {}
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
        end,
    })
end

return M
