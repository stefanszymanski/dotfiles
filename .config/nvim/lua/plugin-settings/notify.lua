local M = {}

M.config = function()
    local notify = require('notify')
    local telescope = require('telescope')
    local whichkey = require('which-key')

    notify.setup {
        stages = 'static',
        render = 'minimal',
        level = vim.log.levels.WARN,
        timeout = 3000,
        minimum_width = 20,
        max_width = 160,
        max_height = 6,
    }

    telescope.load_extension('notify')

    -- Set as default notifier.
    vim.notify = notify

    whichkey.register({
        fn = {':Telescope notify<cr>',  'Notifications'},
    }, {prefix = '<leader>'})
end

return M
