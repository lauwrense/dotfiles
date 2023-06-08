local options = {
    expandtab = true,
    smarttab = true,
    autoindent = true,
    smartindent = true,
    shiftwidth = 4,
    tabstop = 4,
    colorcolumn = "80",

    number = true,
    relativenumber = true,
    numberwidth = 4,
    signcolumn = "yes",
    termguicolors = true,
    guifont = "JetBrainsMono Nerd Font:h17",

    hlsearch = false,
    ignorecase = true,
    smartcase = true,

    list = true,
    listchars = "tab:> ,trail:•,extends:›,precedes:‹",
    spell = false,

    mouse = "a",
    scrolloff = 8,
    sidescrolloff = 8,
    wrap = false,
    splitright = true,
    splitbelow = true,

    autochdir = false,
    hidden = true,
    fileencoding = "utf-8",
    cmdheight = 1,
    completeopt = { "menuone", "noselect", "preview", "noinsert" },

    pumheight = 10,
    showtabline = 1,
    showmode = false,
    updatetime = 200,
    timeoutlen = 1000,

    undofile = true,
    swapfile = true,
    backup = false,

    foldcolumn = "0",
    foldlevel = 99,
    foldlevelstart = 99,
    foldenable = true,

    fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]],
    laststatus = 2,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
