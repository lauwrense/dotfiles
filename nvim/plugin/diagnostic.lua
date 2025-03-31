local function toggle_virtual_text()
    local is_active = vim.diagnostic.config(nil).virtual_text
    if type(is_active) == "boolean" then
        vim.diagnostic.config({
            virtual_lines = false,
            virtual_text = not is_active,
        })
    elseif type(is_active) == "table" then
        vim.diagnostic.config({
            virtual_lines = false,
            virtual_text = is_active.current_line,
        })
    end
end

local function toggle_virtual_current_text()
    local is_active = vim.diagnostic.config(nil).virtual_text
    if type(is_active) == "table" and is_active.current_line then
        vim.diagnostic.config({
            virtual_lines = false,
            virtual_text = false,
        })
    elseif type(is_active) == "boolean" then
        vim.diagnostic.config({
            virtual_lines = false,
            virtual_text = { current_line = true },
        })
    end
end

local function toggle_virtual_lines()
    local is_active = vim.diagnostic.config(nil).virtual_lines
    if type(is_active) == "boolean" then
        vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = not is_active,
        })
    elseif type(is_active) == "table" then
        vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = is_active.current_line,
        })
    end
end

local function toggle_virtual_current_lines()
    local is_active = vim.diagnostic.config(nil).virtual_lines
    if type(is_active) == "table" and is_active.current_line then
        vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = false,
        })
    elseif type(is_active) == "boolean" then
        vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = { current_line = true },
        })
    end
end

vim.keymap.set("n", "<leader>vt", toggle_virtual_text, { remap = true })
vim.keymap.set(
    "n",
    "<leader>vct",
    toggle_virtual_current_text,
    { remap = true }
)
vim.keymap.set("n", "<leader>vl", toggle_virtual_lines, { remap = true })
vim.keymap.set(
    "n",
    "<leader>vcl",
    toggle_virtual_current_lines,
    { remap = true }
)
