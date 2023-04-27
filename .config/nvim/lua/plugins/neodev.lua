local M = {
    'folke/neodev.nvim',
    event = 'VeryLazy',
}

M.config = function()
    require("neodev").setup()
end

return M
