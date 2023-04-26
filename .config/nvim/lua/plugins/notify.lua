local M = {
    'rcarriga/nvim-notify',
    dependencies = 'nvim-telescope/telescope.nvim',
    lazy = false,
    keys = {
        {'<leader>fn', ':Telescope notify<CR>', desc = 'Notifications'}
    }
}

M.config = function()
    local notify = require('notify')
    local telescope = require('telescope')

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
end

return M
