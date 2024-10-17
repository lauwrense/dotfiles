return {
    {
        "williamboman/mason-lspconfig.nvim",
        event = { "BufEnter", "BufNewFile" },
        dependencies = {
            { "williamboman/mason.nvim" },
            { "neovim/nvim-lspconfig" },
        },
        config = function(_, opts)
            local registry = require("mason-registry")
            local mapping =
                require("mason-lspconfig").get_mappings().lspconfig_to_mason
            local lspconfig = require("lspconfig")
            local langs = require("util").get_langs_with_field("lsp")

            --- list of lsps
            --- TODO: Move this to util.lua
            ---@type LanguagePluginLSP[]
            local lsp_list = vim
                .iter(langs)
                :filter(
                    function(_, spec)
                        return spec.lsp ~= nil
                    end
                )
                :map(
                    function(_, spec)
                        return spec.lsp
                    end
                )
                :fold(
                    {},
                    function(acc, spec)
                        vim.iter(spec):each(function(lsp)
                            acc[#acc + 1] = lsp
                        end)
                        return acc
                    end
                )

            -- lsp installed by mason
            local installed_by_mason = vim.iter(lsp_list)
                :filter(function(lsp)
                    return mapping[lsp.name] ~= nil
                        and not registry
                            .get_package(mapping[lsp.name])
                            :is_installed()
                        and lsp["autoinstall"] ~= false
                end)
                :map(function(lsp)
                    local pkg = registry.get_package(mapping[lsp.name])
                    pkg:install()
                    pkg:on(
                        "install:success",
                        vim.schedule_wrap(function()
                            vim.cmd("LspStart")
                        end)
                    )

                    return lsp
                end)
                :totable()

            --- setup the servers
            vim.iter(lsp_list):each(function(lsp)
                if lsp.setup ~= nil then
                    lsp.setup()
                else
                    require("plugins.lang.default").lsp(lsp.name)
                end
            end)

            --- setup autocommand for attaching cmp sources
            local cmp = require("cmp")
            local sources = cmp.get_config().sources or {}

            vim.iter(lsp_list)
                :filter(function(lsp)
                    return lsp.cmp_enabled or false
                end)
                :each(function(lsp)
                    local group = vim.api.nvim_create_augroup(
                        "SetupCmpSources" .. string.upper(lsp.name),
                        {}
                    )
                    vim.api.nvim_create_autocmd(
                        { "BufRead", "BufNew", "FileType" },
                        {
                            pattern = lspconfig[lsp.name].filetypes,
                            group = group,
                            callback = function()
                                if
                                    not vim.iter(sources):any(function(value)
                                        return value.name == "nvim_lsp"
                                    end)
                                then
                                    local new_sources =
                                        { { name = "nvim_lsp" } }
                                    vim.list_extend(new_sources, sources)
                                    sources = new_sources
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
}
