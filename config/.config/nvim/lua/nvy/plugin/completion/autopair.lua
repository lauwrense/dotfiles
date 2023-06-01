return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        local cmp = require("cmp")
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")

        local npair_config = {
            disable_filetype = { "TelescopePrompt" },
            disable_in_macro = false,
            disable_in_visualblock = false,
            disable_in_replace_mode = true,
            ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
            enable_moveright = true,
            enable_afterquote = true,
            enable_check_bracket_line = true,
            enable_bracket_in_quote = true,
            enable_abbr = false,
            break_undo = true,
            check_ts = false,

            map_cr = true,
            map_bs = true,
            map_c_h = false,
            map_c_w = false,

            fast_wrap = {
                map = "<M-e>",
                chars = { "{", "[", "(", '"', "'" },
                pattern = [=[[%'%"%>%]%)%}%,]]=],
                end_key = "$",
                keys = "qwertyuiopzxcvbnmasdfghjkl",

                check_comma = true,
                highlight = "Search",
                highlight_grey = "Comment",
            },
        }

        local Rule = require("nvim-autopairs.rule")
        local npairs = require("nvim-autopairs")
        local cond = require("nvim-autopairs.conds")

        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

        -- Autopairs
        require("nvim-autopairs").setup(npair_config)
    end,
}
