local M = {
    'ojroques/nvim-bufdel',
    cmd = 'BufDel',
    keys = {
        {'<leader>bd', ':BufDel<cr>', desc = 'Delete current', silent = true},
    },
}

return M
