local M = {
    'akinsho/nvim-toggleterm.lua',
    keys = {
        { [[<C-\>]] },
        { '<leader>tv', ':ToggleTerm direction=vertical<CR>', desc = 'Split vertical' },
        { '<leader>ts', ':ToggleTerm direction=horizontal<CR>', desc = 'Split horizontal' },
        { '<leader>tt', ':ToggleTerm direction=tab<CR>', desc = 'Tab' },
        { '<leader>tf', ':ToggleTerm direction=float<CR>', desc = 'Floating' },
    },
    cmd = 'ToggleTerm',
}

M.config = function()
    require('toggleterm').setup({
        open_mapping = [[<C-\>]],
        insert_mappings = true,
        terminal_mappings = true,
        shade_terminals = false,
        start_in_insert = true,
        persist_size = true,
        close_on_exit = true,
        direction = 'float',
        size = function(term)
            if term.direction == 'horizontal' then
                return math.floor(vim.o.lines * 0.4)
            elseif term.direction == 'vertical' then
                return math.floor(vim.o.columns * 0.4)
            end
        end,
        float_opts = {
            border = 'rounded',
            width = function() return math.floor(vim.o.columns * 0.8) end,
            height = function() return math.floor(vim.o.lines * 0.8) end,
        }
    })
end

return M
