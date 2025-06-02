vim.opt.expandtab = false
vim.opt.listchars = {
    tab = "  ",
    trail = "•",
    extends = "›",
    precedes = "‹",
}

require("dap-go").setup()
