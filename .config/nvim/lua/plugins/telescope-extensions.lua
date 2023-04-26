local M = {
    {
        -- Browse and preview media files
        'nvim-telescope/telescope-media-files.nvim',
        dependencies = 'nvim-telescope/telescope.nvim',
        keys = {
            { '<leader>fm', ':Telescope media_files<CR>', desc = 'Media files in workspace' },
        },
        config = function()
            local telescope = require('telescope')
            telescope.setup {
              extensions = {
                media_files = {
                  filetypes = { 'png', 'webp', 'jpg', 'jpeg', 'pdf' },
                  find_cmd = 'rg'
                },
              },
            }
            telescope.load_extension('media_files')
        end
    },
    {
        -- Search and insert Unicode symbols
        'nvim-telescope/telescope-symbols.nvim',
        dependencies = 'nvim-telescope/telescope.nvim',
        keys = {
            { 'gI', ':Telescope symbols<CR>', desc = 'insert symbol' },
        },
        config = function()
            require('telescope').load_extension('symbols')
        end
    },
    {
        -- Browse headings
        -- TODO restrict to certain filetypes
        'crispgm/telescope-heading.nvim',
        dependencies = 'nvim-telescope/telescope.nvim',
        keys = {
            { '<leader>fh', ':Telescope heading<CR>', desc = 'Headings in buffer' },
        },
        config = function()
            require('telescope').load_extension('heading')
        end
    },
}

return M
