local M = {}

M.config = function()
    local legendary = require('legendary')

    vim.g.clever_f_mark_direct = 1
    vim.g.clever_f_chars_match_any_signs = '#'

    legendary.keymaps {
        {';', '<Plug>(clever-f-repeat-forward)'},
        {',', '<Plug>(clever-f-repeat-back)'},
    }
end

return M
