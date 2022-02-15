local M = {}

M.config = function()
    local whichkey = require('which-key')

    vim.g.git_messenger_no_default_mappings = 1
    vim.g.git_messenger_always_into_popup = 1

    whichkey.register({
        gb = {':GitMessenger<cr>', 'Blame'},
    }, {prefix = '<leader>'})
end

return M
