local M = {
    -- Sort lines and lists
    'sQVe/sort.nvim',
    dependencies = {
        'folke/which-key.nvim',
    },
}

M.keys = function()
    local keys = {
        { 'g<C-s>', desc = 'Sort {motion}' },
        { 'g<C-s>', '<esc><cmd>Sort<cr>', desc = 'Sort', mode = 'v' },
    }
    local surroundings = { '\'', '"', '(', ')', '[', ']', '{', '}', '`' }
    for _, char in ipairs(surroundings) do
        table.insert(keys, {'g<C-s>' .. char, 'vi' .. char .. '<esc><cmd>Sort<cr>', desc = 'Sort in ' .. char })
    end
    return keys
end

return M
