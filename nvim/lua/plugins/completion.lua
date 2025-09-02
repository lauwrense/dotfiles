return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = { check_ts = true },
    },
    {
        "saghen/blink.cmp",
        version = "1.*",
        init = function()
            vim.keymap.set("i", "<C-x><C-o>", function()
                require("blink.cmp").show()
                require("blink.cmp").show_documentation()
                require("blink.cmp").hide_documentation()
            end, { silent = false })
        end,
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            completion = {
                list = {
                    selection = { preselect = false, auto_insert = false },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
                trigger = {
                    show_on_keyword = false,
                    show_on_trigger_character = false,
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
        },
        opts_extend = { "sources.default" },
    },
}
