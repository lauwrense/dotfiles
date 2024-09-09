local specs = {}

for _, lang_spec in pairs(require("util").get_langs_with_field("spec")) do
    local spec = lang_spec.spec or {}
    ---@diagnostic disable-next-line
    vim.list_extend(specs, spec)
end

return specs
