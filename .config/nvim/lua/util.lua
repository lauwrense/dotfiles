local path = vim.fn.stdpath('config')
local lang_path = path .. "/lua/plugins/lang"

local M = {}

local langs = {}

for _, file_name in pairs(vim.fn.globpath(lang_path, "*.lua", true, true)) do
    local lang = file_name:gsub(lang_path .. "/", ""):gsub("%.lua$", "")
    if not vim.tbl_contains({ "default", "init" }, lang) then
        langs[lang] = require("plugins.lang." .. lang)
    end
end

---@return table<string, LanguagePlugin>
M.get_lang_specs = function()
    return langs
end

---@param fields ("lsp" | "dap" | "fmt" | "lint" | "test" | "spec")[]
---@return LanguagePlugin[]
M.get_langs_with_fields = function(fields)
    fields = fields or {}

    local langs_with_spec = {}
    for lang_name, spec in pairs(langs) do
        for _, spec_name in ipairs(fields) do
            if spec[spec_name] ~= nil then
                langs_with_spec[lang_name] = {
                    [spec_name] = spec[spec_name]
                }
            end
        end
    end

    return langs_with_spec
end

---@param field LanguagePluginSpecName
---@return table<string, LanguagePlugin>
M.get_langs_with_field = function(field)
    local langs_with_spec = {}

    for lang_name, spec in pairs(langs) do
        if spec[field] ~= nil then
            langs_with_spec[lang_name] = {
                [field] = spec[field]
            }
        end
    end

    return langs_with_spec
end

return M
