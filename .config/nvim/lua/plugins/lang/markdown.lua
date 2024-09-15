---@type LanguagePlugin
return {
    spec = {
        {
            "MeanderingProgrammer/render-markdown.nvim",
            ft = "md",
            dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
            opts = {

            }
        }
    },
    lsp = {
        ["marksman"] = {
            setup = function(server_name)
                require("lspconfig")["marksman"].setup({
                    capabilities = require("plugins.lang.default").make_capabilities()
                })
            end
        }
    }
}
