local M = {
    -- Display a hint when LSP code actions are available
    'kosayoda/nvim-lightbulb',
    event = {'CursorHold', 'CursorHoldI'}
}

M.config = function()
    require('nvim-lightbulb').setup({
        autocmd = {
            enabled = true
        },
        sign = {
            enabled = false,
        },
        virtual_text = {
            enabled = true,
            text = '',
            hl_mode = 'combine',
        },
    })
end

return M
