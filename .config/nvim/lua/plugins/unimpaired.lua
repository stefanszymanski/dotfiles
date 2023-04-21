local M = {
    -- Bindings for en/disable/toggle features, en/decoding text, jumping
    'tpope/vim-unimpaired',
    event = 'VeryLazy',
    dependencies = {
        'tpope/vim-repeat',
        'folke/which-key.nvim',
    },
}

M.config = function()
    local whichkey = require('which-key')
    local deepcopy = vim.deepcopy

    local keymap_features = {
        s = 'spell',
        b = 'background',
        c = 'cursorline',
        x = 'cursorline & cursorcolumn',
        u = 'cursorcolumn',
        n = 'number',
        d = 'diffthis',
        h = 'hlsearch',
        i = 'ignorecase',
        l = 'list',
        r = 'relativenumber',
        p = 'paste',
        v = 'virtualedit',
        w = 'wrap',
    }

    local keymap_sqo = {
        a =             ':previous',
        A =             ':first',
        b =             ':bprevious',
        B =             ':bfirst',
        l =             ':lprevious',
        L =             ':lfirst',
        ['<C-L>'] =     ':lpfile',
        q =             ':cprevious',
        Q =             ':cfirst',
        ['<C-Q>'] =     ':cpfile',
        t =             ':tprevious',
        T =             ':tfirst',
        ['<C-T>'] =     ':ptprevious',
        u =             'Url encode {motion}',
        uu =            'Url encode line',
        x =             'XML encode {motion}',
        xx =            'XML encode line',
        y =             'C string encode {motion}',
        yy =            'C string encode line',
        p =             'Paste above',
        P =             'which_key_ignore',
        e =             'Move line up',
        ['<space>'] =   'Add blank line above',
        f =             'Previous file in directory',
        ['['] =         'Previous function or class',
        o =             deepcopy(keymap_features),
    }
    keymap_sqo.o.name = 'enable'
    whichkey.register(keymap_sqo, {prefix = '['})

    local keymap_sqc = {
        a =             ':next',
        A =             ':last',
        b =             ':bnext',
        B =             ':blast',
        l =             ':lnext',
        L =             ':llast',
        ['<C-L>'] =     ':lnfile',
        q =             ':cnext',
        Q =             ':clast',
        ['<C-Q>'] =     ':cnfile',
        t =             ':tnext',
        T =             ':tlast',
        ['<C-T>'] =     ':ptnext',
        u =             'Url decode {motion}',
        uu =            'Url decode line',
        x =             'XML decode {motion}',
        xx =            'XML decode line',
        y =             'C string decode {motion}',
        yy =            'C string decode line',
        p =             'Paste below',
        P =             'which_key_ignore',
        e =             'Move line down',
        ['<space>'] =   'Add blank line below',
        f =             'Next file in directory',
        n =             'Next SCM conflict',
        [']'] =         'Next function or class',
        o =             deepcopy(keymap_features),
    }
    keymap_sqc.o.name = 'disable'
    whichkey.register(keymap_sqc, {prefix = ']'})

    local keymap_y = {
        o =             deepcopy(keymap_features),
    }
    keymap_y.o.name = 'toggle'
    whichkey.register(keymap_y, {prefix = 'y'})


    whichkey.register({
        u =             'Url encode',
        x =             'XML encode',
        y =             'C string encode',
        e =             'Move lines up',
    }, {prefix = ']', mode = 'v'})

    whichkey.register({
        u =             'Url decode',
        x =             'XML decode',
        y =             'C string decode',
        e =             'Move lines down',
    }, {prefix = ']', mode = 'v'})
end

return M
