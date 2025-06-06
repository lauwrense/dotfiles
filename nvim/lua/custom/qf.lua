local M = {}
local ns = vim.api.nvim_create_namespace("UserCustom")

M.quickfixtextfunc = function(info)
    local items
    local qfbufnr

    if info.quickfix == 1 then
        local qflist =
            vim.fn.getqflist({ id = info.id, items = 0, qfbufnr = 0 })

        items = qflist.items
        qfbufnr = qflist.qfbufnr
    else
        local loclist =
            vim.fn.getqflist({ id = info.id, items = 0, qfbufnr = 0 })

        items = loclist.items
        qfbufnr = loclist.qfbufnr
    end

    local final = {}

    vim.schedule(function ()
    vim.api.nvim_buf_clear_namespace(qfbufnr, ns, 0, -1)
    end)
    for i, item in ipairs(items) do
        local str
        if item.valid == 1 then
            local name = "[No Name]"
            if item.bufnr > 0 then
                name = vim.api.nvim_buf_get_name(item.bufnr)
            end
            name = vim.fs.relpath(vim.fn.getcwd(), name) or name

            str = string.format(
                "%s:%d:%d | %s",
                name,
                item.lnum,
                item.col,
                item.text
            )

            vim.schedule(function()
                local offset = 0
                --- Filename
                vim.api.nvim_buf_set_extmark(qfbufnr, ns, i - 1, 0, {
                    hl_group = "qfFileName",
                    end_col = #name,
                    strict = false,
                })
                offset = #name

                --- Separator
                vim.api.nvim_buf_set_extmark(qfbufnr, ns, i - 1, offset, {
                    hl_group = "qfSeparator1",
                    end_col = offset + 1,
                    strict = false,
                })

                offset = offset + 1

                --- Line
                vim.api.nvim_buf_set_extmark(qfbufnr, ns, i - 1, offset, {
                    hl_group = "qfError",
                    end_col = offset + #tostring(item.lnum),
                    strict = false,
                })

                offset = offset + #tostring(item.lnum)

                --- Separator
                vim.api.nvim_buf_set_extmark(qfbufnr, ns, i - 1, offset, {
                    hl_group = "qfSeparator1",
                    end_col = offset + 1,
                    strict = false,
                })

                offset = offset + 1

                --- Column
                vim.api.nvim_buf_set_extmark(qfbufnr, ns, i - 1, offset, {
                    hl_group = "qfLineNr",
                    end_col = offset + #tostring(item.col),
                    strict = false,
                })

                offset = offset + #tostring(item.col)

                --- Bar Separator
                vim.api.nvim_buf_set_extmark(qfbufnr, ns, i - 1, offset, {
                    hl_group = "qfFileName",
                    end_col = offset + 3,
                    strict = false,
                })

                offset = offset + 3

                --- File
                vim.api.nvim_buf_set_extmark(qfbufnr, ns, i - 1, offset, {
                    hl_group = "@comment",
                    end_col = offset + #item.text,
                    strict = false,
                })

            end)
        else
            str = item.text
        end

        table.insert(final, i, str)
    end

    return final
end

return M
