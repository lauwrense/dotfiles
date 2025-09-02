vim.keymap.set("n", "<M-/>", "<c-w>5>")
vim.keymap.set("n", "<M-m>", "<c-w>5<")
vim.keymap.set("n", "<M-,>", "<c-w>+")
vim.keymap.set("n", "<M-.>", "<c-w>-")

vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>")
vim.keymap.set("n", "K", function()
    local size = tonumber(vim.wo.colorcolumn) or 80

    vim.lsp.buf.hover({
        max_height = size,
        max_width = size,
    })
end)

-- Use neovim as a fuzzy finder
vim.keymap.set("n", "<leader>ff", function()
    vim.ui.input({
        prompt = "Find: ",
        completion = "file_in_path",
    }, function(input)
        if input ~= nil then
            vim.cmd("find " .. input)
        end
    end)
end)

-- 'al' motion
vim.keymap.set({"o"}, "al", ":norm ggVG<cr>:norm <C-o><cr>")
