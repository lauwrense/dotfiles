return {
    {
        "williamboman/mason-lspconfig.nvim",
        -- event = { "BufEnter", "BufNewFile" },
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

            --- list of lsps
            --- TODO: Move this to util.lua
            ---@type [string, LanguagePluginLSP[]][]
            local lsp_list = vim
                .iter(langs)
                ---@param spec LanguagePlugin
                :filter(function(_, spec)
                        return spec.lsp ~= nil
                    end)
                ---@param spec LanguagePlugin
                :map(function(_, spec)
                        return spec.lsp
                    end)
                ---@param spec LanguagePlugin
                :fold({}, function(acc, spec)
                    vim.iter(spec):each(function(e) 
                        acc[#acc + 1] = e
                    end)
                    return acc
                end)

            -- lsp installed by mason
            local installed_by_mason = vim.iter(lsp_list)
                :filter(function(spec)
                    return mapping[spec.name] ~= nil
                        and not registry
                            .get_package(mapping[spec.name])
                            :is_installed()
                        and spec["autoinstall"] ~= false
                end)
                :map(function (spec)
                    local package = registry.get_package(mapping[spec.name])
                    package:install()
                    package:on(
                        "install:success",
                        vim.schedule_wrap(function()
                            vim.cmd("LspStart")
                        end)
                    )

                    return spec
                end)

            --- setup the servers
            vim.iter(lsp_list):each(function (spec)
                if spec.setup ~= nil then
                    spec.setup()
                else
                    require("plugins.lang.default").lsp(spec.name)
                end
            end)

            --- setup autocommand for attaching cmp sources
            vim.iter(lsp_list)
                :filter(function(spec)
                        return spec.cmp_enabled
                    end)
                :each(function (spec)
                    local cmp = require("cmp")

                    local sources = cmp.get_config().sources or {}

                    local group =
                        vim.api.nvim_create_augroup("SetupCmpSources" .. string.upper(spec.name), {})
                    vim.api.nvim_create_autocmd({ "BufRead", "BufNew", "FileType" }, {
                            pattern = require("lspconfig")[spec.name].config_def.filetypes,
                            group = group,
                            callback = function(ev)
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
        },
    },
    {
        "dnlhc/glance.nvim",
        keys = {
            { "gR", "<cmd>Glance references<cr>", "Glance references" },
            { "gD", "<cmd>Glance definitions<cr>", "Glance definitions" },
            {
                "gY",
                "<cmd>Glance type_definitions<cr>",
                "Glance type definitions",
            },
            {
                "gM",
                "<cmd>Glance implementations<cr>",
                "Glance implementations",
            },
        },
    },
    {
        "stevearc/aerial.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            { "<leader>a", "<cmd>AerialToggle!<cr>", desc = "Open Aerial" },
        },
        opts = {},
    },
}
