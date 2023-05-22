return {
    "hrsh7th/nvim-cmp",

    dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lsp-signature-help" },
        { "hrsh7th/cmp-buffer" },
        { "saadparwaiz1/cmp_luasnip" },
        { "FelipeLema/cmp-async-path" },
        { "kdheepak/cmp-latex-symbols" },
        { "hrsh7th/cmp-cmdline" },
        {
            "L3MON4D3/LuaSnip",
            version = "1.*",
            build = "make install_jsregexp",
            dependencies = { "rafamadriz/friendly-snippets" },
        },
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local cmp_config = {}

        -- Looks for completion window
        cmp_config.window = {
            completion = {
                winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                col_offset = -3,
                side_padding = 2,
            },
        }
        cmp_config.formatting = {
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
                vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                -- Source
                vim_item.menu = ({
                    buffer = "[Buffer]",
                    nvim_lsp = "[LSP]",
                    luasnip = "[LuaSnip]",
                    nvim_lua = "[Lua]",
                    latex_symbols = "[LaTeX]",
                    async_path = "[Path]",
                    neorg = "[Neorg]",
                    git = "[Git]",
                })[entry.source.name]
                return vim_item
            end,
        }

        -- Keybindings
        cmp_config.mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping({
                i = function(fallback)
                    if cmp.visible() and cmp.get_active_entry() then
                        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                    else
                        fallback()
                    end
                end,
                s = cmp.mapping.confirm({ select = true }),
                c = function(fallback)
                    if cmp.visible() and cmp.get_active_entry() then
                        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                    else
                        fallback()
                    end
                end,
            }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
        })

        -- Cmp sources
        cmp_config.sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "nvim_lsp_signature_help" },
        }, {
            {
                name = "luasnip",
                option = {
                    show_autosnippets = true,
                    use_show_condition = false,
                },
            },
            { name = "latex_symbols" },
            { name = "buffer" },
            { name = "async_path" },
        })

        -- Setting up cmp for Command mode
        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
                {
                    name = "cmdline",
                    option = {
                        ignore_cmds = { "Man", "!" },
                    },
                },
            }),
        })

        -- Setup snippets
        cmp_config.snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        }

        -- Function to determine whether cmp should be enabled or not
        cmp_config.enabled = function()
            local context = require("cmp.config.context")
            local buftype = vim.api.nvim_buf_get_option(0, "buftype")
            if buftype == "prompt" then
                return false
            end
            if vim.api.nvim_get_mode().mode == "c" then
                return true
            else
                return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
            end
        end

        -- Setup up cmp
        cmp.setup(cmp_config)

        -- Load snippets
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
    end,
}
