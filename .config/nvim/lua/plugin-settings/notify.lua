local M = {}

M.config = function()
    local notify = require('notify')
    local telescope = require('telescope')
    local whichkey = require('which-key')

    notify.setup {
        stages = 'static',
        render = 'minimal',
    }

    telescope.load_extension('notify')

    -- Set as default notifier.
    vim.notify = notify

    whichkey.register({
        -- TODO restrict to certain file types 
        fn = {':Telescope notify<cr>',  'Notifications'},
    }, {prefix = '<leader>'})
end

return M
