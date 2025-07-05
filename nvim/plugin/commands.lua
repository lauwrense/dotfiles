vim.api.nvim_create_user_command("Grep", "silent grep! <args>", {nargs = "+"})
vim.api.nvim_create_user_command("Grepadd", "silent grepadd! <args>", {nargs = "+"})
