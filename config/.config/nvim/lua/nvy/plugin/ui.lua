return {
    {
        "RRethy/vim-illuminate",
        config = function()
            require("illuminate").configure({
                filetypes_denylist = {
                    'dirvish',
                    'fugitive',
                    "NvimTree"
                },
            })
        end
    },
    { "stevearc/dressing.nvim" },
    { "nvim-tree/nvim-web-devicons" },

    -- Colorschemes
    {
        "EdenEast/nightfox.nvim",
        priority = 10000,
    },
    {
        "j-hui/fidget.nvim",
        opts = {
            text = {
                spinner = "dots",
            },
        },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {
                show_current_context = true,
                space_char_blankline = " ",
                show_trailing_blankline_indent = false,
            }

            local group = vim.api.nvim_create_augroup("SetIndentBacklineColorScheme", { clear = true })
            vim.api.nvim_create_autocmd("ColorScheme", {
                group = group,
                callback = function()
                    vim.api.nvim_set_hl(0, "IndentBlanklineSpaceChar", {
                        fg = vim.api.nvim_get_hl(0, { name = "Whitespace" }).fg
                    })
                    vim.api.nvim_set_hl(0, "IndentBlanklineSpaceCharBlankline", {
                        fg = vim.api.nvim_get_hl(0, { name = "Whitespace" }).fg
                    })
                end
            })
        end,
    },

    {
        "rebelot/heirline.nvim",
        config = function()
            local conditions = require("heirline.conditions")
            local utils = require("heirline.utils")
            local function setup_colors()
                return {
                    bg = utils.get_highlight("StatusLine").bg,
                    bright_bg = utils.get_highlight("Folded").bg,
                    bright_fg = utils.get_highlight("Folded").fg,
                    red = utils.get_highlight("DiagnosticError").fg,
                    dark_red = utils.get_highlight("DiffDelete").bg,
                    green = utils.get_highlight("String").fg,
                    blue = utils.get_highlight("Function").fg,
                    gray = utils.get_highlight("NonText").fg,
                    orange = utils.get_highlight("Constant").fg,
                    purple = utils.get_highlight("Statement").fg,
                    cyan = utils.get_highlight("Special").fg,
                    diag_warn = utils.get_highlight("DiagnosticWarn").fg,
                    diag_error = utils.get_highlight("DiagnosticError").fg,
                    diag_hint = utils.get_highlight("DiagnosticHint").fg,
                    diag_info = utils.get_highlight("DiagnosticInfo").fg,
                    git_del = utils.get_highlight("diffRemoved").fg,
                    git_add = utils.get_highlight("diffAdded").fg,
                    git_change = utils.get_highlight("diffChanged").fg,
                }
            end

            local Align = { provider = "%=" }
            local Space = { provider = " " }
            local LeftSep = { provider = "|", hl = { bg = "bg", fg = "grey", bold = true } }

            local mode_names = {
                n = "NORMAL",
                no = "NORMAL?",
                nov = "NORMAL?",
                noV = "NORMAL?",
                ["no\22"] = "N?",
                niI = "NORMAL-I",
                niR = "NORMAL-R",
                niV = "NORMAL-V",
                nt = "TERMINAL",
                v = "VISUAL",
                vs = "VISUAL",
                V = "V-LINE",
                Vs = "V-LINE",
                ["\22"] = "V-BLOCK",
                ["\22s"] = "V-BLOCK",
                s = "SELECT",
                S = "S-LINE",
                ["\19"] = "S-BLOCK",
                i = "INSERT",
                ic = "INSERT-C",
                ix = "INSERT-X",
                R = "REPLACE",
                Rc = "REPLACE",
                Rx = "REPLACE-X",
                Rv = "REPLACE-V",
                Rvc = "REPLACE-V",
                Rvx = "REPLACE-V",
                c = "COMMAND",
                cv = "EX-MODE",
                r = "...",
                rm = "MORE",
                ["r?"] = "?",
                ["!"] = "EXTERN",
                t = "TERMINAL",
            }

            local mode_colors = {
                n = "red",
                i = "green",
                v = "cyan",
                V = "cyan",
                ["\22"] = "cyan",
                c = "orange",
                s = "purple",
                S = "purple",
                ["\19"] = "purple",
                R = "orange",
                r = "orange",
                ["!"] = "red",
                t = "red",
            }

            local ViModeName = {
                init = function(self)
                    self.mode = vim.fn.mode(1)
                end,
                static = {
                    mode_names = mode_names,
                    mode_colors = mode_colors,
                },
                provider = function(self)
                    return " " .. self.mode_names[self.mode] .. " "
                end,
                hl = function(self)
                    local mode = self.mode:sub(1, 1)
                    return {
                        bg = self.mode_colors[mode],
                        fg = "bg",
                        bold = true,
                    }
                end,
                update = {
                    "ModeChanged",
                    pattern = "*:*",
                    callback = vim.schedule_wrap(function()
                        vim.cmd("redrawstatus")
                    end),
                },
            }

            local FileNameBlock = {
                init = function(self)
                    self.filename = vim.api.nvim_buf_get_name(0)
                end,
            }

            local FileIcon = {
                init = function(self)
                    local filename = self.filename
                    local extension = vim.fn.fnamemodify(filename, ":e")
                    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension,
                        { default = true })
                end,
                provider = function(self)
                    return self.icon and (self.icon .. " ")
                end,
                hl = function(self)
                    return { fg = self.icon_color }
                end
            }

            local FileName = {
                init = function(self)
                    local bufnr = vim.api.nvim_get_current_buf()
                    self.filename = vim.api.nvim_buf_get_name(bufnr)
                end,
                provider = function(self)
                    local filename = vim.fn.fnamemodify(self.filename, ":.")
                    if filename == "" then return "[No Name]" end
                    if not conditions.width_percent_below(#filename, 0.25) then
                        filename = vim.fn.pathshorten(filename)
                    end
                    return filename
                end,
                hl = { fg = "blue" },
            }


            local FileFlags = {
                {
                    condition = function()
                        return vim.bo.modified
                    end,
                    provider = "[+]",
                    hl = { fg = "green" },

                },
                {
                    condition = function()
                        return not vim.bo.modifiable or vim.bo.readonly
                    end,
                    provider = "",
                    hl = { fg = "orange" },
                },
            }

            local FileNameModifer = {
                hl = function()
                    if vim.bo.modified then
                        return { fg = "blue", bold = true, force = true }
                    end
                end,
            }

            FileNameBlock = utils.insert(FileNameBlock,
                FileIcon,
                utils.insert(FileNameModifer, FileName),
                FileFlags,
                { provider = '%<' }
            )

            local Git = {
                condition = conditions.is_git_repo,

                init = function(self)
                    self.status_dict = vim.b.gitsigns_status_dict
                    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or
                        self.status_dict.changed ~= 0
                end,

                hl = { fg = "orange", bg = "bg" },
                {
                    -- git branch name
                    provider = function(self)
                        return " " .. self.status_dict.head
                    end,
                    hl = { bold = true },
                },
                {
                    condition = function(self)
                        return self.has_changes
                    end,
                    provider = "(",
                },
                {
                    provider = function(self)
                        local count = self.status_dict.added or 0
                        return count > 0 and ("+" .. count)
                    end,
                    hl = { fg = "git_add" },
                },
                {
                    provider = function(self)
                        local count = self.status_dict.removed or 0
                        return count > 0 and ("-" .. count)
                    end,
                    hl = { fg = "git_del" },
                },
                {
                    provider = function(self)
                        local count = self.status_dict.changed or 0

                        return count > 0 and ("~" .. count)
                    end,
                    hl = { fg = "git_change" },
                },
                {
                    condition = function(self)
                        return self.has_changes
                    end,
                    provider = ")",
                },
            }

            local Diagnostics = {
                condition = conditions.has_diagnostics,
                static = {
                    -- error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
                    -- warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
                    -- info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
                    -- hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
                    error_icon = "",
                    warn_icon = "",
                    info_icon = "",
                    hint_icon = "",
                },

                init = function(self)
                    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
                    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
                    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
                end,

                update = { "DiagnosticChanged", "BufEnter" },

                { provider = " " },
                {
                    provider = function(self)
                        -- 0 is just another output, we can decide to print it or not!
                        return self.errors > 0 and (self.error_icon .. self.errors .. " ")
                    end,
                    hl = { fg = "diag_error" },
                },

                {
                    provider = function(self)
                        return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
                    end,

                    hl = { fg = "diag_warn" },
                },
                {
                    provider = function(self)
                        return self.info > 0 and (self.info_icon .. self.info .. " ")
                    end,
                    hl = { fg = "diag_info" },
                },
                {
                    provider = function(self)
                        return self.hints > 0 and (self.hint_icon .. self.hints)
                    end,
                    hl = { fg = "diag_hint" },
                },
                { provider = " " },
                hl = {
                    bg = "bg",
                },
                LeftSep,
                Space
            }

            local LSPActive = {
                condition = conditions.lsp_attached,
                update = { "LspAttach", "LspDetach" },
                {
                    provider = " LSP ~ ",
                    hl = { fg = "orange", bg = "bg", bold = true },
                },
                {
                    provider = function()
                        local names = {}
                        for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
                            table.insert(names, server.name)
                        end
                        return table.concat(names, " ")
                    end,
                    hl = { fg = "green", bg = "bg", bold = true },
                },
                Space,
                LeftSep,
            }

            local Ruler = {
                { provider = " %(%l/%L%):%2c " },
                hl = {
                    fg = "bg",
                    bg = "purple",
                },
            }

            local FileType = {
                Space,
                {
                    provider = function()
                        return string.upper(vim.bo.filetype)
                    end
                },
                Space,
                hl = {
                    fg = "blue",
                    bg = "bg",
                    bold = true,
                },
            }

            local FileEncoding = {
                provider = function()
                    local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
                    return enc ~= "utf-8" and enc:upper()
                end,
            }

            local HelpFileName = {
                condition = function()
                    return vim.bo.filetype == "help"
                end,
                provider = function()
                    local filename = vim.api.nvim_buf_get_name(0)

                    return vim.fn.fnamemodify(filename, ":t")
                end,
                hl = { fg = "blue" },
            }

            local TerminalName = {
                provider = function()
                    local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
                    return " " .. tname
                end,
                hl = { fg = "blue", bold = true },
            }

            local DAPMessages = {
                condition = function()
                    if not pcall(require, "dap") then return end
                    local session = require("dap").session()
                    return session ~= nil
                end,
                provider = function()
                    return " " .. require("dap").status() .. " "
                end,
                hl = "Debug",
                {
                    provider = "",
                    on_click = {
                        callback = function()
                            require("dap").step_into()
                        end,
                        name = "heirline_dap_step_into",

                    },
                },

                { provider = " " },
                {
                    provider = "",
                    on_click = {
                        callback = function()
                            require("dap").step_out()
                        end,

                        name = "heirline_dap_step_out",
                    },
                },
                { provider = " " },
                {
                    provider = " ",
                    on_click = {
                        callback = function()
                            require("dap").step_over()
                        end,
                        name = "heirline_dap_step_over",
                    },
                },
                { provider = " " },
                {
                    provider = "ﰇ",
                    on_click = {
                        callback = function()
                            require("dap").run_last()
                        end,
                        name = "heirline_dap_run_last",
                    },
                },
                { provider = " " },
                {
                    provider = "",
                    on_click = {
                        callback = function()
                            require("dap").terminate()
                            require("dapui").close({})
                        end,
                        name = "heirline_dap_close",

                    },
                },
                { provider = " " },
            }

            local DefaultStatusline = {
                ViModeName,
                Space,
                FileNameBlock,
                Space,
                Git,
                Align,
                DAPMessages,
                Align,
                Diagnostics,
                LSPActive,
                FileEncoding,
                FileType,
                Ruler,
            }

            local InactiveStatusline = {
                condition = conditions.is_not_active,
                FileType,
                Space,
                FileName,
                FileFlags,
                Align,
            }

            local TerminalStatusline = {
                condition = function()
                    return conditions.buffer_matches({ buftype = { "terminal" } })
                end,
                { condition = conditions.is_active, ViModeName, Space },
                FileType,
                TerminalName,
                Align,
            }

            local SpecialStatusline = {
                condition = function()
                    return conditions.buffer_matches({
                        buftype = { "nofile", "prompt", "help", "quickfix" },
                        filetype = { "^git.*", "fugitive" },
                    })
                end,
                FileType,
                Space,
                HelpFileName,
                Align
            }

            local StatusLines = {
                hl = function()
                    if conditions.is_active() then
                        return "StatusLine"
                    else
                        return "StatusLineNC"
                    end
                end,

                fallthrough = false,

                SpecialStatusline,
                TerminalStatusline,
                InactiveStatusline,
                DefaultStatusline,
            }


            require("heirline").setup({
                statusline = StatusLines,
            })

            vim.api.nvim_create_augroup("Heirline", { clear = true })
            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = function()
                    utils.on_colorscheme(setup_colors)
                end,
                group = "Heirline",
            })
        end,
    }
}
