return {
    {
        "stevearc/oil.nvim",
        name = "oil",
        cmd = {
            "Oil",
        },
        keys = {
            { "<leader>O", "<cmd>Oil<cr>", desc = "Oil" },
        },
        config = function()
            require("oil").setup({
                constrain_cursor = "name",
                skip_confirm_for_simple_edits = true,
                view_options = {
                    show_hidden = true,
                    natural_order = true,
                    is_always_hidden = function(name, _)
                        return name == ".." or name == ".git"
                    end,
                },
                confirmation = {
                    border = "none",
                },
                columns = {
                    "icon",
                    "permissions",
                    "size",
                    "mtime",
                },
            })
        end,
    },
}
