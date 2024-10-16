local specs = {}

specs = vim.iter(require("util").get_langs_with_field("spec"))
    :map(function(_, spec)
        return spec.spec
    end)
    :filter(function (spec)
        return spec ~= nil and #spec > 0
    end)
    :totable()

return specs
