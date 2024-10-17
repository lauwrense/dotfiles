return {
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
    },
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },
    {
        "dnlhc/glance.nvim",
        keys = {
            { "gR", "<cmd>Glance references<cr>", "Glance references" },
            { "gD", "<cmd>Glance definitions<cr>", "Glance definitions" },
            {
                "gY",
                "<cmd>Glance type_definitions<cr>",
                "Glance type definitions",
            },
            {
                "gM",
                "<cmd>Glance implementations<cr>",
                "Glance implementations",
            },
        },
    },
}
