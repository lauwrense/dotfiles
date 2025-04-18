return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = { check_ts = true },
    },
    {
        "saghen/blink.cmp",
        version = "1.*",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                build = "make install_jsregexp",
            },
        },
        init = function ()
            vim.api.nvim_create_autocmd({"LspAttach"}, {
                group = vim.api.nvim_create_augroup("LspAttachKeyMaps", {}),
                callback = function()
                    vim.api.nvim_buf_create_user_command(0, "CompletionToggleLsp", function ()
                        vim.b.completion_lsp = not vim.b.completion_lsp
                    end, {})
                end
            })
        end,
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "default",
                ["<CR>"] = { "accept", "fallback" },
            },
            completion = {
                list = { selection = { preselect = false, auto_insert = true } },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },

                menu = {
                    draw = {
                        columns = {
                            { "label", gap = 1 },
                            { "kind_icon", "kind", gap = 1 },
                        },
                    },
                },
            },
            snippets = { preset = "luasnip" },
            sources = {
                default = function()
                    local success, node = pcall(vim.treesitter.get_node)
                    local source = {}

                    if
                        success
                        and node
                        and vim.tbl_contains(
                            { "comment", "line_comment", "block_comment" },
                            node:type()
                        )
                    then
                        return { "buffer" }
                    else
                        if vim.b.completion_lsp then
                            vim.list_extend(source, { "lsp" })
                        end

                        if vim.bo.filetype == "lua" then
                            vim.list_extend(source, { "lazydev" })
                        else
                            vim.list_extend(source, { "snippets" })
                        end
                    end

                    return source
                end,
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
                -- min_keyword_length = 1,
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },
}
