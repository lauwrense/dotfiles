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

vim.keymap.set("o", "al", ":norm ggVG<cr><C-o>zz")

vim.keymap.set("n", "<leader>vf", function()
    vim.ui.input({
        prompt = ":rightbelow vnew ",
        completion = "dir_in_path",
    }, function(input)
        if input ~= nil and #input > 0 then
            vim.cmd("rightbelow vnew " .. input)
        end
    end)
end)

-- Use neovim as a fuzzy finder
vim.keymap.set("n", "<leader>ff", function()
    vim.ui.input({
        prompt = ":find ",
        completion = "file_in_path",
    }, function(input)
        if input ~= nil and #input > 0 then
            vim.cmd("find " .. input)
        end
    end)
end)


vim.keymap.set("n", "<leader>fv", function()
    vim.ui.input({
        prompt = ":vert rightbelow sfind ",
        completion = "file_in_path",
    }, function(input)
        if input ~= nil and #input > 0 then
            vim.cmd("vertical rightbelow sfind " .. input)
        end
    end)
end)

vim.keymap.set("n", "<leader>fss", function()
    vim.ui.input({
        prompt = ":grep! ",
    }, function(input)
        if input ~= nil and #input > 0 then
            vim.cmd("silent grep! " .. input)
        end
    end)
end)

vim.keymap.set("n", "<leader>fsa", function()
    vim.ui.input({
        prompt = ":grepadd! ",
    }, function(input)
        if input ~= nil and #input > 0 then
            vim.cmd("silent grepadd! " .. input)
        end
    end)
end)
