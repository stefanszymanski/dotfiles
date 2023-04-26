local M = {
    'ojroques/nvim-bufdel',
    cmd = 'BufDel',
    keys = {
        {'<leader>bd', ':BufDel<CR>', desc = 'Delete current', silent = true},
    },
}

return M
