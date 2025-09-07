vim.pack.add({
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "main"
    }
}, { load = true })

local ts = require("nvim-treesitter")
local ensure_installed = {
    "zig",

    -- C
    "c",
    "cpp",
    "make",

    -- Git
    "diff",
    "gitcommit",
    "gitattributes",
    "gitignore",
    "git_rebase",
    "git_config",
}


ts.install(ensure_installed)
ts.update()

local avalable = ts.get_available()
local installed = ts.get_installed()

local function setup_treesitter()
    vim.wo.foldexpr = vim.wo.foldexpr
        or "v:lua.vim.treesitter.foldexpr()"
    vim.schedule(function()
        vim.treesitter.start()
    end)
end

vim.api.nvim_create_autocmd(
    { "BufReadPost", "BufNewFile", "FileType" },
    {
        group = vim.api.nvim_create_augroup("user.treesitter", {}),
        buffer = 0,
        callback = function(args)
            local ft = vim.bo[args.buf].filetype
            local lang = vim.treesitter.language.get_lang(ft)

            if lang == nil then
                return
            end
            if vim.list_contains(installed, lang) then
                setup_treesitter()
            elseif vim.list_contains(avalable, lang) then
                ts.install(lang):await(setup_treesitter)
                installed = ts.get_installed()
            end
        end,
    }
)
