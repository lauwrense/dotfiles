local diagnostic_vt = false

local function set_diagnostic_keymap()
    diagnostic_vt = not diagnostic_vt
    vim.diagnostic.config({
        virtual_text = diagnostic_vt,
    })
    vim.keymap.set("n", "<leader>vd", set_diagnostic_keymap, {
        desc = "diagnostic " .. (diagnostic_vt and "(on)" or "(off)"),
        remap = true,
    })
end

set_diagnostic_keymap()
