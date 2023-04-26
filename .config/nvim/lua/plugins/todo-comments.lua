-- keywords I'm interested in (that's all but WARN)
local keywords = 'FIX,TODO,HACK,PERF,NOTE,TEST'

local M = {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'BufReadPost',
    keys = {
        { ']t', function() require('todo-comments').jump_next() end, desc = 'Next Todo' },
        { '[t', function() require('todo-comments').jump_prev() end, desc = 'Previous Todo' },
        {
            '<leader>dt',
            ':TodoTrouble  keywords=' .. keywords .. ' cwd=<C-R>=expand("%:p")<CR><CR>',
            desc = 'Workspace Todos',
        },
        {
            '<leader>dT',
            ':TodoTrouble keywords=' .. keywords .. '<CR>',
            desc = 'Workspace Todos',
        },
    },
}

M.config = function()
    require('todo-comments').setup({
        highlight = {
            -- only highlight the keyword, not the whole description
            keyword = "bg",
            after = "",
        },
    })
end

return M
