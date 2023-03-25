local M = {}

M.config = function()
    local legendary = require('legendary')
    local whichkey = require('which-key')
    local opts = {silent = true, noremap = true}

    legendary.keymaps {
        {'<A-space>', [[<C-n><cmd>lua require('FTerm').toggle()<cr>]], opts = opts, description = 'Toggle terminal'},
        {'<A-space>', [[<C-n><cmd>lua require('FTerm').toggle()<cr>]], mode = 't', opts = opts, description = 'Toggle terminal'},
    }
end

return M
