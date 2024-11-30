return {
    {
        "hrsh7th/nvim-cmp",
        name = "cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            { "hrsh7th/cmp-buffer" },
            { "saadparwaiz1/cmp_luasnip" },
            { "FelipeLema/cmp-async-path" },
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                build = "make install_jsregexp",
            },
            { "nvim-lua/plenary.nvim" },
            { "hrsh7th/cmp-nvim-lsp" },
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            local config = {
                completion = {
                    completeopt = "menu,menuone,preview,noselect,noinsert",
                },
            }

            -- Looks for completion window
            config.window = {
                completion = {
                    col_offset = -3,
                    side_padding = 2,
                },
                documentation = {
                    max_width = 80,
                    max_height = 80,
                    side_padding = 2,
                },
            }
            config.formatting = {
                -- fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    local kind_icons = {
                        Text = "",
                        Method = "󰆧",
                        Function = "󰊕",
                        Constructor = "",
                        Field = "󰇽",
                        Variable = "󰂡",
                        Class = "󰠱",
                        Interface = "",
                        Module = "",
                        Property = "󰜢",
                        Unit = "",
                        Value = "󰎠",
                        Enum = "",
                        Keyword = "󰌋",
                        Snippet = "",
                        Color = "󰏘",
                        File = "󰈙",
                        Reference = "",
                        Folder = "󰉋",
                        EnumMember = "",
                        Constant = "󰏿",
                        Struct = "",
                        Event = "",
                        Operator = "󰆕",
                        TypeParameter = "󰅲",
                    }

                    -- Kind icons
                    vim_item.kind = string.format(
                        "%s %s",
                        kind_icons[vim_item.kind],
                        vim_item.kind
                    ) -- This concatonates the icons with the name of the item kind
                    -- Source
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        luasnip = "[Snip]",
                        async_path = "[Path]",
                        neorg = "[Norg]",
                        git = "[Git]",
                        buffer = "[Buf]",
                    })[entry.source.name] or "[Else]"
                    return vim_item
                end,
            }

            -- Keybindings
            config.mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping({
                    i = function(fallback)
                        if cmp.visible() and cmp.get_active_entry() then
                            cmp.confirm({
                                behavior = cmp.ConfirmBehavior.Replace,
                                select = false,
                            })
                        else
                            fallback()
                        end
                    end,
                    s = cmp.mapping.confirm({ select = true }),
                    c = cmp.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    }),
                }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            })

            -- Cmp sources
            config.sources = cmp.config.sources({
                { name = "luasnip" },
                { name = "async_path" },
                -- { name = "buffer" },
            })

            -- Setup snippets
            config.snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            }

            config.enabled = function()
                local context = require("cmp.config.context")
                local buftype =
                    vim.api.nvim_get_option_value("buftype", { buf = 0 })

                if buftype == "prompt" then
                    return false
                end
                if vim.api.nvim_get_mode().mode == "c" then
                    return true
                else
                    return not context.in_treesitter_capture("comment")
                        and not context.in_syntax_group("Comment")
                end
            end

            -- Setup up cmp
            cmp.setup(config)
        end,
    },
    {
        "windwp/nvim-autopairs",
        name = "autopairs",
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")

            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

            -- Autopairs
            require("nvim-autopairs").setup({
                disable_in_macro = false,
                check_ts = true,
            })
        end,
    },
}
