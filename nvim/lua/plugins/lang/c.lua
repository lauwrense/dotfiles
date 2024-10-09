---@type LanguagePlugin
return {
    spec = {},
    lsp = {
        ["neocmake"] = {
            setup = function(server_name)
                local cmp = require("cmp")

                local sources = require("cmp").get_config().sources or {}

                local group =
                    vim.api.nvim_create_augroup("setup_cmp_sources_cmake", {})
                vim.api.nvim_create_autocmd(
                    { "BufRead", "BufNew", "FileType" },
                    {
                        pattern = { "CMakeLists.txt" },
                        group = group,
                        callback = function()
                            if
                                not vim.iter(sources):any(function(value)
                                    return value.name == "nvim_lsp"
                                end)
                            then
                                sources[#sources + 1] = { name = "nvim_lsp" }
                            end

                            cmp.setup.buffer({ sources = sources })
                        end,
                    }
                )

                require("lspconfig")["neocmake"].setup({
                    capabilities = require("plugins.lang.default").make_capabilities(),
                })
            end,
        },
    },
}
