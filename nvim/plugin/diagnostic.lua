local diagnostic_vt = true

require("which-key").add({
    "<leader>vd",
    function()
        diagnostic_vt = not diagnostic_vt
        vim.diagnostic.config({
            virtual_text = diagnostic_vt,
        })
    end,
    desc = function()
        return "diagnostic " .. (diagnostic_vt and "(on)" or "(off)")
    end,
})
