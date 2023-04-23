local legendary = require('legendary')
local whichkey = require('which-key')

local opts = {silent = true, noremap = true}

legendary.keymaps {
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
    -- used by plugins: bufdel
    b = {
        name =                                  'Buffers',
        a = {':e#<cr>',                             'Switch to previous buffer'},
        D = {':%bdelete<cr>',                       'Close all buffers'},
        o = {[[:%bdelete|edit #|normal `"<cr>]],    'Close other buffers'},
        y = {':normal! ggVG"+y``<cr>',              'Yank buffer to clipboard'},
        p = {':normal! ggdG"+P<cr>',                'Replace buffer with clipboard'},
    },
    f = {
        name = 'Find'
    },
    l = {
        name = 'LSP',
    },
    d = {
        name = 'Diagnostics'
    },
    -- used by plugins: dap, dap-ui
    x = {
        name = 'Debugging',
        e = {
            name = 'Open in popup',
        },
        s = {
            name = 'Step',
        },
    },
    i = {
        name = 'Insert',
    },
    -- used by plugins: fugitive, gitsigns, git-messenger, gitlinker, diffview
    g = {
        name = 'Git',
    },
    -- used by plugins: session
    s = {
        name = 'Sessions',
    },
    -- used by plugins: conflict-marker
    r = {
        name = 'Resolve conflict',
    },
    -- used by plugins: caser
    c = {
        name = 'Change casing',
    },

} , {prefix = '<leader>', mode = 'n'})

whichkey.register({
    -- used by plugins/radical
    r = {
        name = 'Convert number',
    }
}, { prefix = 'c' })

whichkey.register({
    l = {
        name = 'LSP',
    },
    -- used by plugins/caser
    c = {
        name = 'Change casing',
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

whichkey.register({
    o = {':only<cr>', 'Close other windows'}
}, { prefix = '<C-W>'})
