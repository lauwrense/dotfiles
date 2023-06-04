---@diagnostic disable: redefined-local
return {
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            automatic_installation = true,
            ensure_installed = {
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
            },
            handlers = {
                function(server_name)
                    local capabilities = require("cmp_nvim_lsp").default_capabilities()
                    capabilities.textDocument.foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true,
                    }
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                        on_attach = function(client, bufnr)
                            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

                            vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")
                            vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
                            vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>")
                            vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>")
                            vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
                            vim.keymap.set("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")
                            vim.keymap.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")
                            vim.keymap.set("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")
                            vim.keymap.set("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")
                            vim.keymap.set("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")
                            vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
                            vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
                            vim.keymap.set("n", "[E", function()
                                require("lspsaga.diagnostic"):goto_prev({
                                    severity = vim.diagnostic.severity.ERROR,
                                })
                            end)
                            vim.keymap.set("n", "]E", function()
                                require("lspsaga.diagnostic"):goto_next({
                                    severity = vim.diagnostic.severity.ERROR,
                                })
                            end)
                            vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>")
                            vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")

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
                        end,
                    })
                end,
                ["lua_ls"] = function()
                    require("nvy.plugin.lsp.lua_ls")
                end,
            },
        },
        dependencies = {
            {
                "williamboman/mason.nvim",
                build = ":MasonUpdate",
                opts = {
                    ui = {
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
                    },
                },
            },
            {
                "hrsh7th/cmp-nvim-lsp",
                lazy = false,
            },
            { "neovim/nvim-lspconfig" },
        },
    },

    {
        "glepnir/lspsaga.nvim",
        event = "LspAttach",
        opts = {
            symbol_in_winbar = {
                enable = false,
            },
            ui = {
                title = false,
            },
        },
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = true,
        dependencies = {
            {
                "jay-babu/mason-null-ls.nvim",
                opts = {
                    automatic_installation = false,
                    ensure_installed = {
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
                    },
                },
            },
        },
    },
}
