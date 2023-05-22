local plugins = {
    -- LSP and Diagnostics
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        dependencies = {
            { "williamboman/mason-lspconfig.nvim" },
            { "neovim/nvim-lspconfig" },
            { "jose-elias-alvarez/null-ls.nvim" },
            { "jay-babu/mason-null-ls.nvim" },
        },
    },

    -- Autocomplete
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            {
                "hrsh7th/cmp-nvim-lsp",
                lazy = false,
            },
            {
                "folke/neodev.nvim",
                config = true,
                ft = "lua",
            },
            { "hrsh7th/cmp-nvim-lsp-signature-help" },
            { "hrsh7th/cmp-buffer" },
            { "petertriho/cmp-git" },
            { "davidsierradz/cmp-conventionalcommits" },
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
            { "onsails/lspkind.nvim" },
            { "windwp/nvim-autopairs" },
        },
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        name = "Treesitter",
        build = ":TSUpdate",
        dependencies = {
            { "JoosepAlviste/nvim-ts-context-commentstring" },
            { "windwp/nvim-ts-autotag" },
            { "RRethy/nvim-treesitter-endwise" },
        },
        lazy = true,
    },

    -- Telescope TODO: Configuration
    {
        "nvim-telescope/telescope.nvim",
        name = "Telescope",
        dependencies = {
            { "tsakirist/telescope-lazy.nvim" },
            { "paopaol/telescope-git-diffs.nvim" },
            { "crispgm/telescope-heading.nvim" },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            {
                "nvim-neorg/neorg-telescope",
                ft = "norg",
            },
        },
    },

    -- Git TODO: Configuration
    { "lewis6991/gitsigns.nvim" },
    { "sindrets/diffview.nvim" },
    { "TimUntersberger/neogit" },
    {
        "pwntester/octo.nvim",
        cmd = ":Octo",
    },

    -- Terminal TODO: Configuration
    { "akinsho/toggleterm.nvim" },
    {
        "willothy/flatten.nvim",
        priority = 1001,
    },

    -- Motions TODO: Configuration
    {
        "ggandor/leap.nvim",
        event = "InsertEnter",
    },
    -- { "LeonHeidelbach/trailblazer.nvim" },

    -- Task Runner TODO: Configuration
    {
        "stevearc/overseer.nvim",
        name = "Task Runner",
    },

    -- DAP TODO: Configuration
    {
        "mfussenegger/nvim-dap",
        name = "DAP",
        dependencies = {
            { "jay-babu/mason-nvim-dap.nvim" },
            { "rcarriga/cmp-dap" },
            { "rcarriga/nvim-dap-ui" },
            { "LiadOz/nvim-dap-repl-highlights" },
            { "mfussenegger/nvim-dap-python" },
            { "simrat39/rust-tools.nvim" },
        },
    },

    -- Testing TODO: Configuration
    {
        "rcarriga/neotest",
        name = "Testing",
        dependencies = {
            { "nvim-neotest/neotest-python" },
            { "rouge8/neotest-rust" },
            { "marilari88/neotest-vitest" },
            { "thenbe/neotest-playwright" },
        },
    },

    -- Theme TODO: Configuration
    { "nvim-tree/nvim-web-devicons" },
    { "rebelot/heirline.nvim" },
    { "RRethy/vim-illuminate" },
    { "EdenEast/nightfox.nvim", priority = 1000 },
    {
        "j-hui/fidget.nvim",
        config = true,
    },

    -- Editor QoL
    {
        "kylechui/nvim-surround",
        config = true,
    }, --  TODO: Configuration
    { "numToStr/Comment.nvim" }, --  TODO: Configuration

    -- Extras
    {
        --  TODO: Configuration
        "glepnir/lspsaga.nvim",
        event = "LspAttach",
    },
    { "AckslD/nvim-neoclip.lua" }, --  TODO: Configuration
    { "kevinhwang91/nvim-bqf" }, --  TODO: Configuration
    { "kevinhwang91/nvim-ufo" }, --  TODO: Configuration
    { "luukvbaal/statuscol.nvim" },
    {
        --  TODO: Configuration
        "nvim-tree/nvim-tree.lua",
        cmd = {
            ":NvimTreeOpen",
            ":NvimTreeClose",
            ":NvimTreeToggle",
            ":NvimTreeFocus",
            ":NvimTreeRefresh",
            ":NvimTreeFindFile",
            ":NvimTreeFindFileToggle",
            ":NvimTreeClipboard",
            ":NvimTreeResize",
            ":NvimTreeCollapseKeepBuffers",
            ":NvimTreeGenerateOnAttach",
        },
    },

    -- Note Taking TODO: Configuration
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        ft = "norg",
    },

    -- Util
    { "kevinhwang91/promise-async" },
    { "nvim-lua/plenary.nvim" },
    { "antoinemadec/FixCursorHold.nvim" },
    { "stevearc/dressing.nvim" },
}

return plugins
