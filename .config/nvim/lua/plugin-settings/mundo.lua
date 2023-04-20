local M = {}

M.config = function()
    local whichkey = require('which-key')

    vim.g.mundo_width = 55
    vim.g.mundo_preview_height = 40
    vim.g.mundo_right = 1
    vim.g.mundo_preview_bottom = 1

    whichkey.register({
        u = {':MundoToggle<cr>','Toggle undo history'},
    }, {prefix = '<leader>'})
end

return M
