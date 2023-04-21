local M = {
    'folke/which-key.nvim',
    event = 'BufReadPost',
}

M.config = function()
    require('which-key').setup {
        plugins = {
            spelling = {
                enabled = true,
                suggestions = 30
            },
        },
        layout = {
            height = { min = 2, max = 12 },
            align = 'center',
        },
        ignore_missing = false,
        show_help = false,
    }

    vim.o.timeoutlen = 200
end

return M
