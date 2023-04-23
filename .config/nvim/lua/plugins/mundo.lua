local M = {
    -- Undo history
    'simnalamburt/vim-mundo',
    keys = {
        { '<leader>u', '<cmd>MundoToggle<cr>', desc = 'Toggle undo history' },
    },
}

M.config = function()
    vim.g.mundo_width = 55
    vim.g.mundo_preview_height = 40
    vim.g.mundo_right = 1
    vim.g.mundo_preview_bottom = 1
end

return M
