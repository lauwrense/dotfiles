return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp",             priority = 1000, lazy = false },
            { "williamboman/mason-lspconfig.nvim" },
            { "neovim/nvim-lspconfig" },
            { "jay-babu/mason-null-ls.nvim" },
            { "jose-elias-alvarez/null-ls.nvim" },
        },
        config = function()
            -- Mason Config
            local mason_config = {} -- Use most of the defaults

            -- Mason UI
            mason_config.ui = {
                check_outdated_packages_on_open = true,
                border = "none",
                width = 0.8,
                height = 0.9,
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },

                keymaps = {
                    toggle_package_expand = "<CR>",
                    install_package = "i",
                    update_package = "u",
                    check_package_version = "c",
                    update_all_packages = "U",
                    check_outdated_packages = "C",
                    uninstall_package = "X",
                    cancel_installation = "<C-c>",
                    apply_language_filter = "<C-f>",
                },
            }

            -- Mason-lspconfig configuration
            local mason_lspconfig_config = {}
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }

            mason_lspconfig_config.ensure_installed = {
                "lua_ls",
                "bashls",
                "zls",
                "rust_analyzer",
                "texlab",
                "pylsp",
                -- C
                "arduino_language_server",
                "clangd",
                "neocmake",
                -- Docker
                "dockerls",
                "docker_compose_language_service",
                -- Web
                "astro",
                "svelte",
                "emmet_ls",
                "tsserver",
                "rome",
                "unocss",
                -- Markdown
                "marksman",
            }

            mason_lspconfig_config.automatic_installation = true

            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            local function on_attach(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,

                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({
                                bufnr = bufnr,
                                filter = function(client)
                                    return true
                                end,
                            })
                        end,
                    })
                end
            end

            -- Lspconfig handlers
            mason_lspconfig_config.handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({ capabilities = capabilities, on_attach = on_attach })
                end,
            }

            mason_lspconfig_config.handlers["lua_ls"] = function()
                require("lspconfig").lua_ls.setup({
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            telemetry = {
                                enable = false,
                            },
                        },
                    },
                    on_attach = on_attach,
                })
            end

            -- Null-ls config
            local null_ls_config = {}
            local mason_null_ls_config = {}
            mason_null_ls_config = {
                automatic_installation = false,
            }

            mason_null_ls_config.ensure_installed = {
                "stylua",
                "rustfmt",
                "commitlint",
                "latexindent",
                "black",
                "hadolint", -- Docker
                -- Markdown
                "vale",
                -- C
                "cpplint",
                "cmakelang",
                -- Web
                "rome",
                -- Bash
                "shellcheck",
                "shfmt",
            }

            -- mason_null_ls_config.handlers = {}

            -- null_ls_config.sources = {} -- Anything not supported by mason.

            require("mason").setup(mason_config)
            require("mason-lspconfig").setup(mason_lspconfig_config)
            require("mason-null-ls").setup(mason_null_ls_config)
            require("null-ls").setup(null_ls_config)
        end,
    },
}
