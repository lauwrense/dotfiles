return {
    {
        "ggandor/leap.nvim",
        config = function()
            require('leap').add_default_mappings(true)
        end
    },
    {
        "ggandor/flit.nvim",
        config = function()
            require("flit").setup()
        end
    },
}
