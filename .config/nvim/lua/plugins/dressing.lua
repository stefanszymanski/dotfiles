local M = {
    -- Fancier input and select
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
}

M.config = function()
    -- TODO change highlighting of floats in general
    require('dressing').setup()
end

return M
