return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>F",
                function()
                    require("conform").format({ async = true})
                end,
                desc = "Format buffer",
            },
        },
        init = function()
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
        config = function(_, _)
            local registry = require("mason-registry")
            local langs = require("util").get_langs_with_field("fmt")

            --- list of formatters per ft
            local fmt_list = vim
                .iter(langs)
                :filter(function(_, spec)
                    return spec.fmt ~= nil
                end)
                :fold(
                    {},
                    function(acc, name, spec)
                        if type(spec) == "string" then
                            spec = { spec }
                        end

                        acc[name] = acc[name] or {}
                        vim.iter(spec.fmt):each(function(fmt)
                            acc[name][#acc[name] + 1] = {
                                type(fmt) ~= "table" and fmt or fmt[1],
                                automatic_install = fmt.automatic_install
                                    ~= false,
                            }
                        end)
                        return acc
                    end)

            --- formatters installed by mason
            local installed_by_mason = vim.iter(fmt_list)
                :map(function(ft, fmts)
                    local installed = vim.iter(fmts)
                        :filter(function(fmt)
                            return not registry
                                .get_package(fmt[1])
                                :is_installed() and fmt.automatic_install
                        end)
                        :map(function(fmt)
                            local pkg = registry.get_package(fmt[1])
                            pkg:install()
                            return fmt
                        end)
                        :totable()
                    return { ft, installed }
                end)
                :totable()

            local fmt_by_ft = vim.iter(fmt_list)
                :fold({}, function(acc, ft, fmts)
                    acc[ft] = vim.iter(fmts)
                        :map(function(fmt)
                            return fmt[1]
                        end)
                        :totable()

                    return acc
                end)

            require("conform").setup({
                formatters_by_ft = fmt_by_ft,
            })
        end,
    },
}
