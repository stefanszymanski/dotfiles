local M = {
    -- Fancier input and select
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
}

M.config = function()
    require('dressing').setup()
end

return M
