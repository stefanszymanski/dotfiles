local M = {}

M.config = function()
    local telescope = require('telescope')

    telescope.setup {
        defaults = {
            mappings = {
                i = {
                    ['<C-h>'] = telescope.extensions.hop.hop,
                }
            }
        }
    }

    telescope.load_extension('hop')
end

return M
