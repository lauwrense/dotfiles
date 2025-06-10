vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.api.nvim_create_autocmd({"BufWinEnter", "FileType"}, {
    callback = function()
        if vim.bo.buftype == "" then
            vim.opt_local.colorcolumn = tostring(vim.b.textwidth or 80)
        else
            vim.opt_local.colorcolumn = ""
        end
    end,
})

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes:1"
vim.opt.termguicolors = true
vim.opt.guifont = "JetBrainsMono Nerd Font:h17"

vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.list = true
vim.opt.listchars = {
    tab = "> ",
    trail = "•",
    extends = "›",
    precedes = "‹",
}
vim.opt.spell = false

vim.opt.mouse = ""
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
vim.opt.wrap = false
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.autochdir = false
vim.opt.hidden = true

vim.opt.pumheight = 10
vim.opt.showtabline = 1

vim.opt.showmode = false
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 1000

vim.opt.undofile = true
vim.opt.swapfile = true
vim.opt.backup = false

vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldtext = ""

vim.opt.fillchars = [[eob: ,fold: ]]
vim.opt.laststatus = 3

vim.g.exrc = true
vim.g.shortmess = "ltToOCFI"
