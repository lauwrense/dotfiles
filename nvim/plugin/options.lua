vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.colorcolumn = "80"

vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "FileType" }, {
    callback = function(args)
        if vim.bo[args.buf].buftype ~= "" then
            vim.opt_local.colorcolumn = ""
        end
    end,
})

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes:1"
vim.opt.guifont = "JetBrainsMono Nerd Font:h17"

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

vim.opt.pumheight = 10

vim.opt.showmode = false

vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.updatetime = 200
vim.opt.path:append("**")

vim.opt.fillchars = [[eob: ,fold: ]]
vim.opt.laststatus = 3
