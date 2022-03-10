local legendary = require('legendary')
local whichkey = require('which-key')

local opts = {silent = true, noremap = true}

legendary.bind_keymaps {
    -- Resize splits
    {'<C-Up>',    ':resize +4<cr>',          opts = opts, description = 'Increase window height by 4'},
    {'<C-Down>',  ':resize -4<cr>',          opts = opts, description = 'Decrease window height by 4'},
    {'<C-Left>',  ':vertical resize +4<cr>', opts = opts, description = 'Increase window width by 4'},
    {'<C-Right>', ':vertical resize -4<cr>', opts = opts, description = 'Decrease window width by 4'},

    -- Switch buffers
    {'<A-a>', ':bnext<cr>', opts = opts, description = 'Next buffer'},
    {'<A-x>', ':bprev<cr>', opts = opts, description = 'Previous buffer'},

    -- Switch tabs
    {'<A-A>', ':tabnext<cr>', opts = opts, description = 'Next tab'},
    {'<A-X>', ':tabprev<cr>', opts = opts, description = 'Previous tab'},

    -- Display diagnostics
    {'+', ':lua vim.diagnostic.open_float({scope = "cursor"})<cr>', opts = opts, description = 'Show diagnostics for cursor'},

    -- Cycle through diagnostics
    {'<A-n>', ':lua vim.diagnostic.goto_next()<cr>', opts = opts, description = 'Next dianostic'},
    {'<A-p>', ':lua vim.diagnostic.goto_prev()<cr>', opts = opts, description = 'Previous diagnostic'},
    -- Cycle through errors
    {'<A-N>', ':lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<cr>', opts = opts, description = 'Next error'},
    {'<A-P>', ':lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<cr>', opts = opts, description = 'Previous error'},

    -- x,X,s,S without yanking
    {'x', '"_x', opts = opts, mode = {'n', 'v'}},
    {'X', '"_X', opts = opts, mode = {'n', 'v'}},
    {'s', '"_s', opts = opts, mode = {'n', 'v'}},
    {'S', '"_S', opts = opts, mode = {'n', 'v'}},
}

whichkey.register({
    w = {':w<cr>',                              'Save buffer'},
    W = {':wa<cr>',                             'Save all buffers'},
    q = {':wqa<cr>',                            'Quit'},
    Q = {':qa!<cr>',                            'Quit without saving'},
    b = {
        name =                                  'Buffers',
        a = {':e#<cr>',                             'Switch to previous buffer'},
        d = {':bdelete<cr>',                        'Close current buffer'},
        D = {':%bdelete<cr>',                       'Close all buffers'},
        o = {[[:%bdelete|edit #|normal `"<cr>]],    'Close other buffers'},
        y = {':normal! ggVG"+y``<cr>',              'Yank buffer to clipboard'},
        p = {':normal! ggdG"+P<cr>',                'Replace buffer with clipboard'},
    },
    v = {
        name =                                  'Windows',
        c = {':close<cr>',                          'Close window'},
        h = {':hide<cr>',                           'Hide window'},
        o = {':only<cr>',                           'Close other windows'},
    },
    ['<leader>'] = {
        name = 'Misc'
    },
    f = {
        name = 'Find'
    },
    l = {
        name = 'LSP',
        d = {
            name = 'Diagnostics'
        }
    },
    i = {
        name = 'Insert',
    },
    g = {
        name = 'Git',
        x = {
            name = 'Actions',
        }
    },
} , {prefix = '<leader>', mode = 'n'})

whichkey.register({
    l = {
        name = 'LSP',
    },
} , {prefix = '<leader>', mode = 'v'})

whichkey.register({
    y = {'"+y', 'Yank {motion} to clipboard'},
    p = {'"+p', 'Put clipboard behind cursor'},
    Y = {'"+Y', 'Yank [count] lines to clipboard'},
    P = {'"+P', 'Put clipboard before cursor'},
    [8] =       'Show UTF8 hex value',
    J =         'Join [count=2] lines without fixing spacing',
    t =         'Next tab',
    T =         'Previous tab',
    q =         'Format {motion}',
    r =         'Replace character under cursor with {char}',
    w =         'Format {motion} and keep cursor',
    nn =        'Init incremental selection',
} , {prefix = 'g', mode = 'n', noremap = false})

whichkey.register({
    y = {'"+y', 'Yank to clipboard'},
    Y = {'"+Y', 'Yank lines to clipboard'},
    r = {
        name =  'Incremental selection',
        n =         'Increment to upper named parent',
        c =         'Increment to the upper scope',
        m =         'Decrement to the previous named node',
    }
} , {prefix = 'g', mode = 'v', noremap = false})