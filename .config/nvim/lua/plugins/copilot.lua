local M = {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    dependencies = {
        {
            'zbirenbaum/copilot-cmp',
            dependencies = 'hrsh7th/nvim-cmp',
        },
    },
    keys = {
        { '<leader>pe', '<cmd>Copilot enable<CR>', desc = 'Enable' },
        { '<leader>pd', '<cmd>Copilot disable<CR>', desc = 'Disable' },
        { '<leader>ps', '<cmd>Copilot status<CR>', desc = 'Status' },
        { '<leader>pp', '<cmd>Copilot panel<CR>', desc = 'Panel' },
    },
}

M.config = function()
    require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = true },
    })
    require('copilot_cmp').setup({
        formatters = {
            insert_text = require("copilot_cmp.format").remove_existing
          },
    })
end

return M
