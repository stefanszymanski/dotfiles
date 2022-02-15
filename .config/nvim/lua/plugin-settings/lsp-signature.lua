local M = {}

M.config = function()
    require('lsp_signature').setup {
        hint_enable = false,
        handler_opts = {
            border = 'single'
        },
        max_height = 16,
        max_width = 120,
        toggle_key = '<C-s>',
    }
end

return M
