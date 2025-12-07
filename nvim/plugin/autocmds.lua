vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank({ higroup = "Visual" })
    end,
})

--- BIG FILE
local max_fsize = 2 * 1024 * 1024 -- 2 MiB

local shutdown_group = vim.api.nvim_create_augroup("user.bigfile.shutdown", {})
vim.api.nvim_create_autocmd({ "BufReadPost", }, {
    group = shutdown_group,
    callback = function(args)
        local ok, file = pcall(vim.uv.fs_stat, args.file)

        if not ok or file and file.size > max_fsize then
            vim.treesitter.stop(args.buf)
            return
        end
    end,
})


local available_ts = nil
local installed_ts = nil

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "FileType" }, {
    group = vim.api.nvim_create_augroup("user.treesitter", {}),
    buffer = 0,
    callback = function(args)
        local ts = require("nvim-treesitter")
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)

        if lang == nil then
            return
        end

        available_ts = available_ts or ts.get_available()
        installed_ts = installed_ts or ts.get_installed()

        local function setup_treesitter()
            vim.wo.foldexpr = vim.wo.foldexpr or "v:lua.vim.treesitter.foldexpr()"
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            vim.schedule(function()
                vim.treesitter.start()
            end)
        end

        if vim.list_contains(installed_ts, lang) then
            setup_treesitter()
        elseif vim.list_contains(available_ts, lang) then
            ts.install(lang):await(setup_treesitter)
            installed_ts = ts.get_installed()
        end
    end,
})

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
    group = shutdown_group,
    callback = function(args)
        local ok, file = pcall(vim.uv.fs_stat, args.file)

        if not ok or file and file.size > max_fsize then
            vim.lsp.buf_detach_client(args.buf, args.data.client_id)
            return
        end

        vim.lsp.completion.enable(true, args.data.client_id, args.buf)
    end,
})
