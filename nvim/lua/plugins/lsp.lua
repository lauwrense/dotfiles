return {
    {
        "williamboman/mason-lspconfig.nvim",
        event = { "BufEnter", "BufNewFile" },
        dependencies = {
            { "williamboman/mason.nvim" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "neovim/nvim-lspconfig" },
        },
        config = function(_, opts)
            local registry = require("mason-registry")
            local mapping =
                require("mason-lspconfig").get_mappings().lspconfig_to_mason
            local lspconfig = require("lspconfig")
            local langs = require("util").get_langs_with_field("lsp")

            opts.handlers = {}

            vim.iter(langs):each(function(_, specs)
                vim.iter(specs.lsp)
                    :filter(function(name, _)
                        return lspconfig[name] ~= nil
                    end)
                    :each(function(name, spec)
                        if
                            mapping[name] ~= nil
                            and not registry
                                .get_package(mapping[name])
                                :is_installed()
                            and spec["autoinstall"] ~= false
                        then
                            local package = registry.get_package(mapping[name])
                            package:install()
                            package:on(
                                "install:success",
                                vim.schedule_wrap(function()
                                    vim.cmd("LspStart")
                                end)
                            )
                        end

                        if spec.setup ~= nil then
                            spec.setup("")
                        else
                            require("plugins.lang.default").lsp(name)
                        end
                    end)
            end)

            vim.api.nvim_exec_autocmds("FileType", {})
        end,
    },
    {
        "williamboman/mason.nvim",
        event = { "BufEnter", "BufNewFile" },
        build = ":MasonUpdate",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },
    {
        "folke/trouble.nvim",
        opts = {
            auto_close = true,
        },
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },

            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {

                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {

                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
    {
        "dnlhc/glance.nvim",
        keys = {
            {"gR", "<cmd>Glance references<cr>", "Glance references"},
            {"gD", "<cmd>Glance definitions<cr>", "Glance definitions"},
            {"gY", "<cmd>Glance type_definitions<cr>", "Glance type definitions"},
            {"gM", "<cmd>Glance implementations<cr>", "Glance implementations"},
        }
    }
}
