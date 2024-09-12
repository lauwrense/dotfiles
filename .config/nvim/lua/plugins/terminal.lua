return {
    {
        "willothy/flatten.nvim",
        opts = {
            window = {
                open = "alternate"
            }
        },
        config = true,
        lazy = false,
        priority = 1001,
    },
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        cmd = {"ToggleTerm"},
        opts = {
            shade_terminals = false,
            on_open = function ()
                vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], {})
            end
        },
        config = true
    }
}
