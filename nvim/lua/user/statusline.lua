local M = {
    colors = {
        red = "%#StatusLineRed#",
        blue = "%#StatusLineBlue#",
        yellow = "%#StatusLineYellow#",
        orange = "%#StatusLineOrange#",
        purple = "%#StatusLinePurple#",
        green = "%#StatusLineGreen#",
        diff_branch = "%#StatusLineDiffBranch#",
        diff_add = "%#StatusLineDiffAdded#",
        diff_change = "%#StatusLineDiffChanged#",
        diff_removed = "%#StatusLineDiffRemoved#",
    },
    modes = {
        n = "N",
        i = "I",
        v = "V",
        V = "V",
        ["\22"] = "V",
        c = "C",
        s = "S",
        S = "S",
        ["\19"] = "S",
        R = "R",
        cv = "E",
        r = "M",
        ["!"] = "!",
        t = "T",
    },
}

local function mode()
    local mode_colors = {
        n = M.colors.red,
        i = M.colors.yellow,
        v = M.colors.purple,
        V = M.colors.purple,
        ["\22"] = M.colors.purple,
        c = M.colors.blue,
        s = M.colors.green,
        S = M.colors.green,
        ["\19"] = M.colors.green,
        R = M.colors.orange,
        r = M.colors.orange,
        ["!"] = M.colors.red,
        t = M.colors.red,
    }

    local current_mode = vim.api.nvim_get_mode().mode
    local color = mode_colors[current_mode] or "%#NonText#"
    local mode_char = M.modes[current_mode]

    return string.format("[%s%s%%*]", color, mode_char)
end

local function git()
    local status = vim.b.gitsigns_status_dict
    if status == nil then
        return ""
    end

    local head = status.head
    local added, changed, removed = status.added, status.changed, status.removed
    local str = {}

    table.insert(str, string.format("%s%s", M.colors.diff_branch, head))

    if added and added > 0 then
        table.insert(str, string.format("%s+%d", M.colors.diff_add, added))
    end

    if changed and changed > 0 then
        table.insert(str, string.format("%s~%d", M.colors.diff_change, changed))
    end

    if removed and removed > 0 then
        table.insert(
            str,
            string.format("%s-%d", M.colors.diff_removed, removed)
        )
    end

    vim.api.nvim_create_autocmd("User", {
        pattern = "GitSignsUpdate",
        group = vim.api.nvim_create_augroup("user.statusline.git", {}),
        callback = function()
            vim.cmd.redrawstatus()
        end,
    })

    return table.concat(str, " ")
end

local function bufname()
    local buf_name = vim.api.nvim_buf_get_name(0)

    if vim.bo.buftype == "terminal" then
        local cmd = buf_name:gsub(".*/", "")
        if cmd:find("toggleterm") ~= nil then
            cmd = cmd:gsub(";.*", "")
        end
        return string.format("%s[%s]", M.colors.red, cmd)
    end

    if vim.bo.filetype == "help" then
        return string.format(
            "%s[Help] %%*%s",
            M.colors.purple,
            vim.fs.basename(buf_name)
        )
    end

    if vim.bo.buftype == "quickfix" then
        return string.format("%s[Quickfix]", M.colors.blue)
    end

    if vim.bo.buftype == "nofile" then
        return string.format("%s[%s]", M.colors.green, vim.bo.filetype)
    end

    if vim.bo.buftype == "prompt" then
        return string.format("%s[Prompt]", M.colors.purple)
    end

    local fname = {
        "%*",
        vim.fs.relpath(vim.fn.getcwd(), buf_name) or "[No Name]",
    }

    if vim.bo.modified then
        table.insert(fname, "[+]")
    end

    if not vim.bo.modifiable or vim.bo.readonly then
        table.insert(fname, "[RO]")
    end

    return table.concat(fname, " ")
end

local function filetype()
    local ft = vim.bo.filetype
    local buftype = vim.bo.buftype

    if buftype ~= "" or #ft < 1 then
        return ""
    end

    return string.format("[%s%s%%*]", M.colors.green, ft)
end

M.render = function()
    local left = table.concat({
        mode(),
        git(),
    }, " ")

    local center = table.concat({
        bufname(),
    }, " ")

    local right = table.concat({
        filetype(),
        "%*%l / %L : %2c   ",
    }, " ")

    local left_width = vim.api.nvim_eval_statusline(left, {}).width
    local right_width = vim.api.nvim_eval_statusline(right, {}).width
    local center_width = vim.api.nvim_eval_statusline(center, {}).width
    local cols = vim.o.columns

    local left_pad = math.floor((cols - center_width) / 2) - left_width
    local right_pad = math.ceil((cols - center_width) / 2) - right_width

    local sl = {}
    table.insert(sl, left)
    table.insert(sl, string.rep(" ", left_pad))
    table.insert(sl, center)
    table.insert(sl, string.rep(" ", right_pad))
    table.insert(sl, right)
    return table.concat(sl)
end

return M
