require("editorconfig").properties.max_line_length = function(_, val)
    vim.wo.colorcolumn = val
end
