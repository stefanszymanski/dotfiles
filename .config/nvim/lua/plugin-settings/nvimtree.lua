local M = {}

M.config = function()
    local tree = require('nvim-tree')
    local whichkey = require('which-key')

    tree.setup {
        view = {
            width = 50,
            adaptive_size = true,
            number = true,
            relativenumber = true,
        },
        diagnostics = {
            enable = true
        },
        actions = {
            open_file = {
                quit_on_open = true
            }
        }
    }

    whichkey.register({
        n = {'<cmd>NvimTreeToggle<cr>',   'Toggle file tree'},
        N = {'<cmd>NvimTreeFindFile<cr>', 'Show current document in file tree'},
    }, {prefix = '<leader>'})
end

return M
