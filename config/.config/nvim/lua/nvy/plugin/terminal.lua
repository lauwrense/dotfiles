return {
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup({
                size = function(term)
                    if term.direction == "horizontal" then
                        return 15
                    elseif term.direction == "vertical" then
                        return vim.o.columns * 0.4
                    end
                end,
                on_create = function(term)
                    term.cmd = "clear"
                    local opts = { buffer = 0 }
                    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
                    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
                    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)

                    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
                    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
                    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
                    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
                end,
            })

            local Terminal = require("toggleterm.terminal").Terminal
            local terminal_list = {
                Terminal:new({ count = 1 }),
                Terminal:new({ count = 2 }),
            }

            local current_term = 1
            local max_term = 5
            local recent_direction = "horizontal"

            local function term_toggle()
                recent_direction = "horizontal"
                terminal_list[current_term]:toggle(nil, recent_direction)
            end

            local function cycle_term()
                local is_term_open = terminal_list[current_term]:is_open()
                local is_term_focused = terminal_list[current_term]:is_focused()

                if is_term_open then
                    terminal_list[current_term]:close()

                    if current_term == #terminal_list then
                        current_term = 1
                    else
                        current_term = current_term + 1
                    end
                end

                terminal_list[current_term]:open(nil, recent_direction)
            end


            local function cycle_hor_ver()
                if recent_direction == "horizontal" then
                    recent_direction = "vertical"
                elseif recent_direction == "vertical" then
                    recent_direction = "horizontal"
                end

                for _, term in ipairs(terminal_list) do
                    if term:is_open() then
                        term:close()
                        term:open(nil, recent_direction)
                    end
                end
            end

            local function new_term()
                if not (#terminal_list >= max_term) then
                    local new_term_idx = #terminal_list + 1
                    terminal_list[new_term_idx] = Terminal:new({
                        count = new_term_idx,
                        direction = recent_direction
                    })
                    if terminal_list[current_term]:is_open() then
                        terminal_list[current_term]:close()
                    end
                    current_term = new_term_idx
                    terminal_list[current_term]:open()
                end
            end



            vim.keymap.set("n", "<leader>tt", term_toggle, { remap = true, desc = "Open Term" })
            vim.keymap.set("n", "<leader>tl", cycle_hor_ver, { remap = true, desc = "Cycle Layout" })
            vim.keymap.set("n", "<leader>tn", new_term, { remap = true, desc = "Spawn new Term" })
            vim.keymap.set("n", "<leader>tc", cycle_term, { remap = true, desc = "Cycle Terms" })
        end
    },
    {
        "willothy/flatten.nvim",
        priority = 10001,
        opts = {
            nest_if_no_args = false,
            window = {
                open = "alternate"
            }
        }
    },
}
