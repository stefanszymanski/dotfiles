local legendary = require('legendary')
local whichkey = require('which-key')

local opts = {silent = true, noremap = true}

legendary.keymaps {
    -- Cycle through buffers
    {'<M-a>', ':bnext<CR>', opts = opts, description = 'Next buffer'},
    {'<M-x>', ':bprev<CR>', opts = opts, description = 'Previous buffer'},

    -- Cycle though tabs
    {'<M-A>', ':tabnext<CR>', opts = opts, description = 'Next tab'},
    {'<M-X>', ':tabprev<CR>', opts = opts, description = 'Previous tab'},

    -- Display diagnostics
    {'+', ':lua vim.diagnostic.open_float({scope = "cursor"})<CR>', opts = opts, description = 'Show diagnostics for cursor'},

    -- Cycle through diagnostics
    {'<M-n>', ':lua vim.diagnostic.goto_next()<CR>', opts = opts, description = 'Next dianostic'},
    {'<M-p>', ':lua vim.diagnostic.goto_prev()<CR>', opts = opts, description = 'Previous diagnostic'},
    -- Cycle through errors
    {'<M-N>', ':lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>', opts = opts, description = 'Next error'},
    {'<M-P>', ':lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>', opts = opts, description = 'Previous error'},

    -- x,X,s,S without yanking
    {'x', '"_x', opts = opts, mode = {'n', 'v'}},
    {'X', '"_X', opts = opts, mode = {'n', 'v'}},
    {'s', '"_s', opts = opts, mode = {'n', 'v'}},
    {'S', '"_S', opts = opts, mode = {'n', 'v'}},

    -- indent in visual mode without leaving visual mode
    { '<', '<gv', mode = 'v'},
    { '>', '>gv', mode = 'v'},

    -- move lines in normal mode
    { "<C-M-j>", ":m .+1<CR>==", mode = 'n'},
    { "<C-M-k>", ":m .-2<CR>==", mode = 'n'},
    -- move lines in visual mode
    { "<C-M-j>", ":m '>+1<CR>gv=gv", mode = 'v'},
    { "<C-M-k>", ":m '<-2<CR>gv=gv", mode = 'v'},
}

whichkey.register({
    w = {':w<CR>',                              'Save buffer'},
    W = {':wa<CR>',                             'Save all buffers'},
    q = {':wqa<CR>',                            'Quit'},
    Q = {':qa!<CR>',                            'Quit without saving'},
    -- used by plugins: bufdel
    b = {
        name =                                  'Buffers',
        a = {':e#<CR>',                             'Switch to previous buffer'},
        -- d is added by plugins/bufdel.lua
        D = {':%bdelete<CR>',                       'Close all buffers'},
        o = {[[:%bdelete|edit #|normal `"<CR>]],    'Close other buffers'},
        y = {':normal! ggVG"+y``<CR>',              'Yank buffer to clipboard'},
        p = {':normal! ggdG"+P<CR>',                'Replace buffer with clipboard'},
    },
    -- used by plugins: telescope
    f = {
        name = 'Find'
    },
    -- used by plugins: telescope
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
    -- used by plugins: fugitive, gitsigns, git-messenger, gitlinker, diffview, telescope
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
    -- used by plugins: copilot
    p = {
        name = 'Copilot',
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
    o = {':only<CR>', 'Close other windows'}
}, { prefix = '<C-W>'})
