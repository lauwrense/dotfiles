return {
    {
        "stevearc/oil.nvim",
        name = "oil",
        cmd = {
            "Oil",
        },
        keys = {
            { "<leader>O", function ()
                require("oil").open_float(nil, {
                    preview = {
                        vertical = true,
                    }
                })
            end, desc = "Oil" },
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
                float = {
                    border = {" "},
                    max_height = 0.85,
                    max_width = 0.80,

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
