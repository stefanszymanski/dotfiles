local M = {}

M.config = function()
    local telescope = require('telescope')
    local whichkey = require('which-key')

    telescope.setup {
        extensions = {
            file_browser = {
                theme = 'ivy'
            }
        }
    }

    local open_current_document = function()
        local dir = vim.fn.expand('%:h')
        telescope.extensions.file_browser.file_browser {path = dir}
    end

    telescope.load_extension('file_browser')

    whichkey.register({
        m = {open_current_document, 'Toggle file browser'},
    }, {prefix = '<leader>'})
end

return M
