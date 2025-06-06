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
        init = function()
            vim.api.nvim_create_autocmd({ "LspAttach" }, {
                group = vim.api.nvim_create_augroup("user.lsp.on.attach", {}),
                callback = function(args)
                    local bufnr = args.buf

                    vim.api.nvim_buf_create_user_command(
                        bufnr,
                        "CompletionToggleLsp",
                        function()
                            vim.b[bufnr].completion_lsp =
                                not vim.b[bufnr].completion_lsp
                        end,
                        {}
                    )
                end,
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
                    end

                    return source
                end,
                per_filetype = {
                    lua = { inherit_defaults = true, "lazydev" },
                },
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
