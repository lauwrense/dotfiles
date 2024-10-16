return {
    {
        "mfussenegger/nvim-lint",
        event = "VeryLazy",
        config = function (_, _)
            local registry = require("mason-registry")
            local langs = require("util").get_langs_with_field("lint")

            --- list of linters per ft
            local lint_list = vim
                .iter(langs)
                :filter(function(_, spec)
                    return spec.lint ~= nil
                end)
                :fold(
                    {},
                    function(acc, name, spec)
                        if type(spec) == "string" then
                            spec = { spec }
                        end

                        acc[name] = acc[name] or {}
                        vim.iter(spec.lint):each(function(lint)
                            acc[name][#acc[name] + 1] = {
                                type(lint) ~= "table" and lint or lint[1],
                                automatic_install = lint.automatic_install
                                    ~= false,
                            }
                        end)
                        return acc
                    end)


            --- linters installed by mason
            local installed_by_mason = vim.iter(lint_list)
                :map(function(ft, linters)
                    local installed = vim.iter(linters)
                        :filter(function(linter)
                            return not registry
                                .get_package(linter[1])
                                :is_installed() and linter.automatic_install
                        end)
                        :map(function(linter)
                            local pkg = registry.get_package(linter[1])
                            pkg:install()
                            return linter
                        end)
                        :totable()
                    return { ft, installed }
                end)
                :totable()


            local lint_by_ft = vim.iter(lint_list)
                :fold({}, function(acc, ft, fmts)
                    acc[ft] = vim.iter(fmts)
                        :map(function(fmt)
                            return fmt[1]
                        end)
                        :totable()

                    return acc
                end)

            require('lint').linters_by_ft = lint_by_ft

            vim.api.nvim_create_autocmd({"BufWritePost"}, {
                group = vim.api.nvim_create_augroup("LintOnBufWritePost", {}),
                callback = function ()
                    require("lint").try_lint()
                end
            })
        end
    }
}
