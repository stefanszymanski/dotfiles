local M = {
    'folke/trouble.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-telescope/telescope.nvim',
        'kyazdani42/nvim-web-devicons',
    },
    cmd = 'Trouble',
    keys = {
        {'<leader>lc', ':Trouble lsp_references<cr>', desc = 'References' },
        {'<leader>dd', ':Trouble document_diagnostics<cr>', desc = 'In buffer' },
        {'<leader>dw', ':Trouble workspace_diagnostics<cr>', desc = 'In workspace' },
        {'<leader>dq', ':Trouble quickfix<cr>', desc = 'Quickfix' },
        {'<leader>dl', ':Trouble loclist<cr>', desc = 'Loclist' },
    },
}

M.config = function()
    local trouble = require('trouble')
    local actions = require('trouble.providers.telescope')
    local telescope = require('telescope')

    trouble.setup {
        height = 18,
    }

    telescope.setup {
        defaults = {
            mappings = {
              i = { ["<c-t>"] = actions.open_with_trouble },
              n = { ["<c-t>"] = actions.open_with_trouble },
            },
        },
    }
end

return M
