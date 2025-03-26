return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = { check_ts = true },
    },
    {
        "saghen/blink.cmp",
        version = "1.*",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                build = "make install_jsregexp",
            },
            { "xzbdmw/colorful-menu.nvim" },
        },
        opts = {
            keymap = {
                preset = "default",
                ["<CR>"] = { "accept", "fallback" },
            },
            completion = {
                list = { selection = { preselect = false, auto_insert = true } },
                documentation = {
                    auto_show = true,
                },
                menu = {
                    draw = {
                        components = {
                            label = {
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(
                                        ctx
                                    )
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(
                                        ctx
                                    )
                                end,
                            },
                        },
                    },
                },
            },
            snippets = { preset = "luasnip" },
            sources = {
                default = function(ctx)
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
                    elseif vim.bo.filetype == "lua" then
                        vim.list_extend(source, { "lazydev", "path" })
                    else
                        vim.list_extend(source, { "snippets" })
                    end

                    if vim.b.completion_lsp ~= false then
                        vim.list_extend(source, { "lsp" })
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
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },
}
