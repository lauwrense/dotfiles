return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = {"FzfLua"},
    keys = {
        {
            "<leader>ff",
            function()
                require("fzf-lua").files()
            end,
            desc = "Find Files"
        },
        {
            "<leader>fs",
            function()
                require("fzf-lua").grep()
            end,
            desc = "Grep String"
        },
        {
            "<leader>fg",
            function()
                require("fzf-lua").live_grep()
            end,
            desc = "Live Grep"
        },
        {
            "<leader>fh",
            function()
                require("fzf-lua").helptags()
            end,
            desc = "Help Tags"
        },
        {
            "<leader>fm",
            function()
                require("fzf-lua").manpages()
            end,
            desc = "Man Pages"
        },
        { "<leader>fB", "<cmd>FzfLua tabs previewer=builtin<cr>", desc = "Tabs" },
        { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
        { -- This is "based" from folke/noice.nvim
            "<leader>fn",
            function()
                local fzf = require("fzf-lua")
                local fzf_utils = require("fzf-lua.utils")
                local notify = require("notify")
                local time_format = require("notify")._config().time_formats().notification

                local hl = {
                    ["TRACE"] = "NonText",
                    ["DEBUG"] = "NonText",
                    ["INFO"] = "DiagnosticVirtualTextInfo",
                    ["WARN"] = "DiagnosticVirtualTextWarn",
                    ["ERROR"] = "DiagnosticVirtualTextError",
                }

                fzf.fzf_exec(function(fzf_cb)
                    local notifications = notify.history()

                    for _, notif in ipairs(notifications) do
                        local icon_level = fzf_utils.ansi_from_hl(
                            hl[notif.level],
                            " " .. (notif.icon or "") .. " " .. (notif.level or "") .. " "
                        )
                        local time = fzf_utils.ansi_from_hl("Special", vim.fn.strftime(time_format, notif.time) or "") .. " "
                        local title = fzf_utils.ansi_from_hl("Title", notif.title[1] or " ") .. " "
                        local content = fzf_utils.ansi_from_hl("NonText", notif.message[1] or "")

                        fzf_cb(icon_level .. time .. title .. content)
                    end

                    fzf_cb(nil)
                end, {
                })
            end,
            desc = "Notifications"
        },
    },
    config = function()
        require("fzf-lua").setup({
            fzf_colors = true,
            winopts = {
                preview = {
                    default = "bat",
                    border = "noborder",
                },
            },
            previewers = {
                bat = {
                    theme = "Catppuccin Frappe",
                },
            },
            files = {
                cwd_prompt = false,
            },
            keymap = {
                builtin = {
                    ["<c-f>"] = "preview-page-down",
                    ["<c-b>"] = "preview-page-up",
                },
                fzf = {
                    ["ctrl-f"] = "preview-page-down",
                    ["ctrl-b"] = "preview-page-up",
                }
            }
        })

        vim.api.nvim_set_hl(0, "FzfLuaBorder", {
            fg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg,
            bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg,
        })
    end
}
