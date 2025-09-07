---@type vim.lsp.Config
return {
    cmd = { "zls" },
    filetypes = { "zig", "zir" },
    root_markers = { "zls.json", "build.zig", ".git" },
    workspace_required = false,
    settings = {
        zls = {
            semantic_tokens = "partial",
            warn_style = true,
        },
    },
}
