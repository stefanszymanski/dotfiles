local M = {}

M.config = function()
    local whichkey = require('which-key')

    vim.g.neomux_start_term_map = '<C-S><C-S>'
    vim.g.neomux_start_term_split_map = '<C-S>x'
    vim.g.neomux_start_term_vsplit_map = '<C-S>v'
    vim.g.neomux_winjump_map_prefix = '<C-W>'
    vim.g.neomux_winswap_map_prefix = '<C-W>z'
    vim.g.neomux_yank_buffer_map = nil
    vim.g.neomux_paste_buffer_map = nil
    vim.g.neomux_term_sizefix_map = '<C-S>r'
    vim.g.neomux_exit_term_mode_map = '<C-S>'

    vim.g.neomux_dont_fix_term_ctrlw_map = 1

    whichkey.register({
        ['<C-S>'] = 'Start terminal',
        x = 'Start terminal in split',
        v = 'Start terminal in vertical split',
        r = 'Redraw terminal',
    }, { prefix = '<C-S>' })

    local cw_map = {
        z = 'Switch with window #'
    }
    for i = 1, 9, 1 do
        cw_map[tostring(i)] = 'which_key_ignore'
        cw_map['z' .. i] = 'Switch with window ' .. i
    end
    whichkey.register(cw_map, { prefix = '<C-W>' })
end

return M
