local M = {}

M.config = function()
    local autosession = require('auto-session')
    local expand = vim.fn.expand
    local whichkey = require('which-key')

    autosession.setup {
        auto_session_create_enabled = false
    }

    whichkey.register({
        s = {
            name = 'Sessions',
            w = {':SaveSession<cr>', 'Save session'},
            d = {':DeleteSession<cr>', 'Delete session'},
        }
    }, {prefix = '<leader>'})
end

return M

