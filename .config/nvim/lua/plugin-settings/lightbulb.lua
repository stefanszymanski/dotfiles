local M = {}

M.config = function()
    lightbulb_config = {
        sign = {
            enabled = false,
        },
        virtual_text = {
            enabled = true,
        },
    }
    -- Always hint if there are code actions available
    vim.cmd [[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb(lightbulb_config)]]
end

return M
