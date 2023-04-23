local M = {
    -- Git decorations, actions, motions
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VeryLazy',
}

M.keys = function()
    local util = require('plugins/util/gitsigns')
    local keys = {
        -- show diff
        { 'yoD', util.toggle_diff, desc = 'Git diff' },
        { '[oD', util.enable_diff, desc = 'Git diff' },
        { ']oD', util.disable_diff, desc = 'Git diff' },
        -- show blame of current line as virtual text
        { 'yoB', '<cmd>Gitsigns toggle_current_line_blame<cr>', desc = 'Git line blame' },
        -- hunk actions
        { '<leader>ga', '<cmd>Gitsigns stage_hunk<cr>', desc = 'Stage hunk', mode = { 'n', 'v' } },
        { '<leader>gu', '<cmd>Gitsigns reset_hunk<cr>', desc = 'Reset hunk', mode = { 'n', 'v' } },
        { '<leader>gp', '<cmd>Gitsigns preview_hunk<cr>', desc = 'Preview hunk' },
        -- hunk motions
        { ']h', ':Gitsigns next_hunk<cr>', desc = 'Next Git hunk (also <A-u>)' },
        { '[h', ':Gitsigns prev_hunk<cr>', desc = 'Previous Git hunk (also <A-d>)' },
        { '<A-u>', ':Gitsigns next_hunk<cr>', desc = 'Next Git hunk' },
        { '<A-d>', ':Gitsigns prev_hunk<cr>', desc = 'Previous Git hunk' },
    }
    return keys
end

M.config = function()
    require('gitsigns').setup({
        signs = {
            add          = { hl = 'GitSignsAdd', text = '┃', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
            change       = { hl = 'GitSignsChange', text = '┃', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
            delete       = { hl = 'GitSignsDelete', text = '◢', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
            topdelete    = { hl = 'GitSignsDelete', text = '◥', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
            changedelete = { hl = 'GitSignsChange', text = '┃', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        },
        current_line_blame_opts = {
            delay = 150,
        },
    })
end

return M
