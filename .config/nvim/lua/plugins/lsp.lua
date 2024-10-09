return {
    {
        "williamboman/mason-lspconfig.nvim",
        event = {"BufEnter", "BufNewFile"},
        dependencies = {
            { "williamboman/mason.nvim" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "neovim/nvim-lspconfig" },
        },
        opts = {
            -- ensure_installed = {
            --     "rust_analyzer",
            --     "texlab",
            --     "pylsp",
            --     -- C
            --     "clangd",
            --     "neocmake",
            --     -- Markdown
            --     "marksman",
            -- },
        },
        config = function(opts)
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

            -- for _, spec in pairs(langs) do
            --     spec = spec or {}
            --     local spec_lsp = vim.tbl_keys(spec.lsp or {})
            --
            --     for _, lsp_name in ipairs(spec_lsp) do
            --         -- If supported by lspconfig
            --         if lspconfig[lsp_name] ~= nil then
            --             -- Check mason for lsp
            --             if
            --                 mapping[lsp_name] ~= nil
            --                 and not registry
            --                 .get_package(mapping[lsp_name])
            --                 :is_installed()
            --                 and spec.lsp[lsp_name]["autoinstall"] ~= false
            --             then
            --                 local package =
            --                     registry.get_package(mapping[lsp_name])
            --                 package:install()
            --                 package:on(
            --                     "install:success",
            --                     vim.schedule_wrap(function()
            --                         vim.cmd("LspStart")
            --                     end)
            --                 )
            --             end
            --
            --             if spec.lsp[lsp_name].setup ~= nil then
            --                 spec.lsp[lsp_name].setup("")
            --             else
            --                 require("plugins.lang.default").lsp(lsp_name)
            --             end
            --         end
            --     end
            -- end

            vim.api.nvim_exec_autocmds("FileType", {})
        end,
    },
    {
        "williamboman/mason.nvim",
        event = {"BufEnter", "BufNewFile"},
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
}
