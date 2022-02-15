local M = {}

M.config = function()
    local telescope = require('telescope')
    local whichkey = require('which-key')

    telescope.load_extension('media_files')

    telescope.setup {
      extensions = {
        media_files = {
          filetypes = {'png', 'webp', 'jpg', 'jpeg', 'pdf'},
          find_cmd = 'rg'
        },
      },
    }

    whichkey.register({
        fm = {':Telescope media_files<cr>', 'Media files in workspace'},
    }, {prefix = '<leader>'})
end

return M
