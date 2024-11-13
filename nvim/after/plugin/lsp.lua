vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        signs = true,
    })

--- Lua
vim.api.nvim_create_autocmd({ "Filetype" }, {
    pattern = { "lua" },
    callback = function()
        assert(
            vim.fn.exepath("lua-language-server") ~= nil,
            "lua-language-server not found in path"
        )

        vim.lsp.start({
            name = "lua_ls",
            cmd = { "lua-language-server" },
            root_dir = vim.fs.root(0, {
                ".luarc.json",
                ".luarc.jsonc",
                ".luacheckrc",
                ".stylua.toml",
                "stylua.toml",
                "selene.toml",
                "selene.yml",
            }),
        })
    end,
})

--- Zig
vim.api.nvim_create_autocmd({ "Filetype" }, {
    pattern = { "zig", "zir" },
    callback = function()
        assert(vim.fn.exepath("zls") ~= nil, "zls not found in path")

        vim.lsp.start({
            name = "zls",
            cmd = { "zls" },
            root_dir = vim.fs.root(0, {
                "zls.json",
                "build.zig",
                ".git",
            }),
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })
    end,
})

--- Go
vim.api.nvim_create_autocmd({ "Filetype" }, {
    pattern = { "go", "gomod", "gowork", "gotmpl" },
    callback = function()
        assert(vim.fn.exepath("gopls") ~= nil, "gopls not found in path")

        vim.lsp.start({
            name = "gopls",
            cmd = { "gopls" },
            root_dir = vim.fs.root(0, {
                "go.work",
                "go.mod",
                ".git",
            }),
        })
    end,
})

--- Markdown
-- vim.api.nvim_create_autocmd({ "Filetype" }, {
--     pattern = { "markdown", "markdown.mdx" },
--     callback = function()
--         assert(vim.fn.exepath("marksman") ~= nil, "marksman not found in path")
--         vim.lsp.start({
--             name = "marksman",
--             cmd = { "marksman", "server" },
--             root_dir = vim.fs.root(0, {
--                 ".marksman.toml",
--                 ".git",
--             }),
--         })
--     end,
-- })

--- Cmake
vim.api.nvim_create_autocmd({ "Filetype" }, {
    pattern = { "cmake" },
    callback = function()
        assert(
            vim.fn.exepath("neocmakelsp") ~= nil,
            "neocmakelsp not found in path"
        )

        vim.lsp.start({
            name = "neocmakelsp",
            cmd = { "neocmakelsp", "--stdio" },
            root_dir = vim.fs.root(0, {
                ".git",
                "build",
                "cmake",
            }),
        })
    end,
})

--- Ocaml
vim.api.nvim_create_autocmd({ "Filetype" }, {
    pattern = {
        "ocaml",
        "menhir",
        "ocamlinterface",
        "ocamllex",
        "reason",
        "dune",
    },
    callback = function()
        assert(vim.fn.exepath("ocamllsp") ~= nil, "ocamllsp not found in path")

        vim.lsp.start({
            name = "ocamllsp",
            cmd = { "ocamllsp" },
            root_dir = vim.fs.root(0, function(name, _)
                local root_files = {
                    "esy.json",
                    "package.json",
                    ".git",
                    "dune-project",
                    "dune-workspace",
                }
                return name:match(".*%.opam") ~= nil or root_files
            end),
            get_language_id = function(_, filetype)
                local ft = {
                    menhir = "ocaml.menhir",
                    ocaml = "ocaml",
                    ocamlinterface = "ocaml.interface",
                    ocamllex = "ocaml.ocamllex",
                    reason = "reason",
                    dune = "dune",
                }

                return ft[filetype]
            end,
        })
    end,
})
