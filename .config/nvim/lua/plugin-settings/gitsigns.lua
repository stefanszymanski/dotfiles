local M = {}

M.config = function()
    local extras = require('plugin-extras.gitsigns')
    local gitsigns = require('gitsigns')
    local legendary = require('legendary')
    local whichkey = require('which-key')
    local opts = {silent = false, noremap = false}

    gitsigns.setup {
        signs = {
            add          = {hl = 'GitSignsAdd'   , text = '┃', numhl = 'GitSignsAddNr'   , linehl = 'GitSignsAddLn'},
            change       = {hl = 'GitSignsChange', text = '┃', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'},
            delete       = {hl = 'GitSignsDelete', text = '◢', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
            topdelete    = {hl = 'GitSignsDelete', text = '◥', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
            changedelete = {hl = 'GitSignsChange', text = '┃', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'},
        },
        current_line_blame_opts = {
            delay = 150,
          },
    }

    -- Highlight lines for displaying diff
    whichkey.register({oD = {extras.toggle_diff,  'Git diff'}}, {prefix = 'y'})
    whichkey.register({oD = {extras.enable_diff,  'Git diff'}}, {prefix = '['})
    whichkey.register({oD = {extras.disable_diff, 'Git diff'}}, {prefix = ']'})

    -- Display blame as virtual text
    whichkey.register({oB = {'<cmd>Gitsigns toggle_current_line_blame<cr>', 'Git line blame'}}, {prefix = 'y'})

    -- Hunk actions
    whichkey.register({
        ga = {'<cmd>Gitsigns stage_hunk<cr>',   'Stage hunk'},
        gu = {'<cmd>Gitsigns reset_hunk<cr>',   'Reset hunk'},
        gp = {'<cmd>Gitsigns preview_hunk<cr>', 'Preview hunk'},
    }, {prefix = '<leader>', mode = 'n'})
    whichkey.register({
        ga = {'<cmd>Gitsigns stage_hunk<cr>', 'Stage hunk'},
        gu = {'<cmd>Gitsigns reset_hunk<cr>', 'Reset hunk'},
    }, {prefix = '<leader>', mode = 'v'})

    -- Hunk text object
    -- whichkey.register({h = {'<cmd>Gitsigns select_hunk<cr>', 'Git hunk'}}, {prefix = 'i', mode = 'o'})
    -- whichkey.register({h = {'<cmd>Gitsigns select_hunk<cr>', 'Git hunk'}}, {prefix = 'i', mode = 'x'})

    -- Hunk motions
    whichkey.register({h = {[[<cmd>Gitsigns next_hunk<cr>]], 'Next Git hunk (also <A-u>)'}}, {prefix = ']'})
    whichkey.register({h = {[[<cmd>Gitsigns prev_hunk<cr>]], 'Previous Git hunk (also <A-d>)'}}, {prefix = '['})
    legendary.bind_keymaps {
        {'<A-u>', '[h', opts = opts, description = 'Next Git hunk'},
        {'<A-d>', ']h', opts = opts, description = 'Previous Git hunk'},
    }
end

return M
