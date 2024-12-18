local M = {}

local function bracket_wrap(str, do_hl)
    if do_hl ~= false then
        return string.format("%%#StatusLineText#[%s]", str)
    else
        return string.format("[%s]", str)
    end
end

local function highlight(str, hi)
    return string.format("%%#%s#%s%%#StatusLineText#", hi, str)
end

local function vimode()
    local modes = {
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
    }

    local mode_colors = {
        n = "StatusLineRed",
        i = "StatusLineYellow",
        v = "StatusLinePurple",
        V = "StatusLinePurple",
        ["\22"] = "StatusLinePurple",
        c = "StatusLineBlue",
        s = "StatusLineGreen",
        S = "StatusLineGreen",
        ["\19"] = "StatusLineGreen",
        R = "StatusLineOrange",
        r = "StatusLineOrange",
        ["!"] = "StatusLineRed",
        t = "StatusLineRed",
    }

    local color = mode_colors[vim.fn.mode():sub(1, 1)] or "NonText"

    return bracket_wrap(highlight(modes[vim.fn.mode():sub(1, 1)], color))
end

local function git_head()
    local status = vim.b.gitsigns_status_dict

    if status == nil then
        return ""
    end

    local str = highlight(status.head, "StatusLineDiffBranch")

    return str
end

local function git_status()
    local status = vim.b.gitsigns_status_dict
    if status == nil then
        return ""
    end

    local str = {}

    if status.added ~= nil and status.added > 0 then
        table.insert(
            str,
            highlight(string.format("+%d", status.added), "StatusLineDiffAdded")
        )
    end

    if status.changed ~= nil and status.changed > 0 then
        table.insert(
            str,
            highlight(string.format("~%d", status.changed), "StatusLineDiffChanged")
        )
    end

    if status.removed ~= nil and status.removed > 0 then
        table.insert(
            str,
            highlight(string.format("-%d", status.removed), "StatusLineDiffRemoved")
        )
    end

    vim.api.nvim_create_autocmd("User", {
        pattern = "GitSignsUpdate",
        group = vim.api.nvim_create_augroup("UpdateStatusLineGit", {}),
        callback = function()
            vim.cmd("redrawstatus")
        end,
    })

    return table.concat(str, " ")
end

local function bufname()
    if vim.bo.buftype == "terminal" then
        local cmd = vim.api.nvim_buf_get_name(0):gsub(".*/", "")
        if cmd:find("toggleterm") ~= nil then
            cmd = cmd:gsub(";.*", "")
        end
        return highlight(bracket_wrap(cmd, false), "StatusLineRed")
    end

    if vim.bo.filetype == "help" then
        local filename = vim.api.nvim_buf_get_name(0)
        return highlight("[Help] ", "StatusLinePurple")
            .. vim.fn.fnamemodify(filename, ":t:r")
    end

    if vim.bo.buftype == "quickfix" then
        return highlight(bracket_wrap("Quickfix", false), "StatusLineBlue")
    end

    if vim.bo.buftype == "nofile" then
        return highlight(
            bracket_wrap(vim.bo.filetype, false),
            "StatusLineGreen"
        )
    end

    if vim.bo.buftype == "prompt" then
        return highlight(
            bracket_wrap(vim.bo.filetype, false),
            "StatusLinePurple"
        )
    end

    local fn = { vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.") }
    if fn[1] == "" then
        return "[No Name]"
    end

    if vim.bo.modified then
        table.insert(fn, "[+]")
    end

    if not vim.bo.modifiable or vim.bo.readonly then
        table.insert(fn, "[RO]")
    end

    return table.concat(fn, " ")
end

local function filetype()
    local disable =
        { "toggleterm", "terminal", "nofile", "prompt", "help", "quickfix" }
    if
        not (
            vim.list_contains(disable, vim.bo.filetype)
            or vim.list_contains(disable, vim.bo.buftype)
        ) and vim.bo.buftype == ""
    then
        return bracket_wrap(highlight(vim.bo.filetype, "StatusLineGreen"))
    end
    return ""
end

M.render = function()
    local sl = {}

    local left = table.concat({
        vimode(),
        git_head(),
        git_status(),
    }, " ")

    local center = table.concat({
        bufname(),
    }, " ")

    local right = table.concat({
        filetype(),
        "%l / %L : %2c   ",
    }, " ")

    local left_pad = math.floor(vim.o.columns / 2)
        - vim.api.nvim_eval_statusline(left, {}).width
        - math.floor(vim.api.nvim_eval_statusline(center, {}).width / 2)

    local right_pad = math.floor(vim.o.columns / 2)
        - vim.api.nvim_eval_statusline(right, {}).width
        - math.floor(vim.api.nvim_eval_statusline(center, {}).width / 2)

    table.insert(sl, 1, left)
    table.insert(sl, 2, string.rep(" ", left_pad))
    table.insert(sl, 3, center)
    table.insert(sl, 4, string.rep(" ", right_pad))
    table.insert(sl, 5, right)
    return table.concat(sl, "")
end

return M
