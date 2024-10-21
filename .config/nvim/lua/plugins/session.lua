local M = {
    {
        -- Manage sessions, identified by their root directory
        'rmagatti/auto-session',
        lazy = false,
        keys = {
            {'<leader>sw', ':SessionSave<CR>', desc = 'Save session'},
            {'<leader>sd', ':SessionDelete<CR>', desc = 'Delete session'},
        },
        config = function()
            require('auto-session').setup({
                auto_session_create_enabled = false
            })
        end
    },
    {
        -- List sessions with Telescope
        'rmagatti/session-lens',
        dependencies = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
        keys = {
            -- FIXME the command SessionSearch doesn't exist
            { '<leader>ss', ':SearchSession<CR>', desc = 'List sessions' }
        },
        config = function()
            require('session-lens').setup()
            require('telescope').load_extension('session-lens')
        end
    },
}

return M
