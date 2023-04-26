local M = {
    'nvim-neo-tree/neo-tree.nvim',
    branch = "v2.x",
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
        's1n7ax/nvim-window-picker',
    },
    keys = {
        { '<leader>n', '<cmd>NeoTreeFocusToggle<CR>', desc = 'Toggle file tree' },
        { '<leader>N', '<cmd>NeoTreeRevealToggle<CR>', desc = 'Reveal current document in file tree' },
    }
}

M.config = function()
    local neotree = require('neo-tree')
    neotree.setup({
        close_if_last_window = true,
        window = {
            width = 60,
            mappings = {
                ['<C-v>'] = 'open_vsplit',
                ['<C-x>'] = 'open_split',
            }
        },
        event_handlers = {
          {
            -- Close neotree when opening a file
            event = "file_opened",
            handler = function()
                neotree.close_all()
            end
          },

        }
    })
end

return M
