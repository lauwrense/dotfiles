local function toggle_virtual_text()
    local is_active = vim.diagnostic.config(nil).virtual_text

    if type(is_active) == "table" then
        is_active = is_active.current_line
    end

    vim.diagnostic.config({
        virtual_lines = false,
        virtual_text = not is_active,
    })
end

local function toggle_virtual_lines()
    local is_active = vim.diagnostic.config(nil).virtual_lines

    if type(is_active) == "table" then
        is_active = is_active.current_line
    end

    vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = not is_active,
    })
end

vim.keymap.set("n", "<leader>vt", toggle_virtual_text, { remap = true })
vim.keymap.set("n", "<leader>vl", toggle_virtual_lines, { remap = true })

vim.keymap.set("n", "<leader>dd", vim.diagnostic.setqflist, {})
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, {})
