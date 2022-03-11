local M = {}

M.config = function()
    local trouble = require('trouble')
    local actions = require("trouble.providers.telescope")
    local telescope = require('telescope')
    local whichkey = require('which-key')

    trouble.setup {
        height = 18,
    }

    telescope.setup {
        defaults = {
            mappings = {
              i = { ["<c-z>"] = actions.open_with_trouble },
              n = { ["<c-z>"] = actions.open_with_trouble },
            },
        },
    }

    whichkey.register({
        l = {
            c = { ':Trouble lsp_references<cr>', 'References' },
        },
        d = {
            d = { ':Trouble document_diagnostics<cr>', 'In buffer' },
            w = { ':Trouble workspace_diagnostics<cr>', 'In workspace' },
            q = { ':Trouble quickfix<cr>', 'Quickfix' },
            l = { ':Trouble loclist<cr>', 'Loclist' },
        },
    }, { prefix = '<leader>' })
end

return M
