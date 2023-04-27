local M = {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    dependencies = {
        {
            'zbirenbaum/copilot-cmp',
            dependencies = 'hrsh7th/nvim-cmp',
        },
    },
}

M.config = function()
    require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
    })
    require('copilot_cmp').setup({
        formatters = {
            insert_text = require("copilot_cmp.format").remove_existing
          },
    })
end

return M
