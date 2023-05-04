local M = {
    'folke/trouble.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-telescope/telescope.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    cmd = 'Trouble',
    keys = {
        { '<leader>lc', ':Trouble lsp_references<CR>', desc = 'References' },
        { '<leader>dd', ':Trouble document_diagnostics<CR>', desc = 'In buffer' },
        { '<leader>dw', ':Trouble workspace_diagnostics<CR>', desc = 'In workspace' },
        { '<leader>dq', ':Trouble quickfix<CR>', desc = 'Quickfix' },
        { '<leader>dl', ':Trouble loclist<CR>', desc = 'Loclist' },
    },
}

M.config = function()
    local trouble = require('trouble')
    -- local actions = require('trouble.providers.telescope')
    -- local telescope = require('telescope')

    trouble.setup({
        height = 18,
        signs = {
            error = "",
            warning = "",
            hint = "",
            information = "",
            other = "﫠"
        },
    })

    -- FIXME setup() gets already called in plugins/telescope.lua, calling it a second time overrides the previous setup
    -- telescope.setup {
    --     defaults = {
    --         mappings = {
    --           i = {
    --                 ["<C-r>"] = actions.open_with_trouble
    --           },
    --           n = {
    --                 ["<C-r>"] = actions.open_with_trouble
    --           },
    --         },
    --     },
    -- }
end

return M
