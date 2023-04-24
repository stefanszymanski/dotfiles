local M = {
    'github/copilot.vim',
    event = 'VeryLazy',
    keys = {
        {'<leader>pe', '<cmd>Copilot enable<cr>', desc = 'Enable'},
        {'<leader>pd', '<cmd>Copilot disable<cr>', desc = 'Disable'},
        {'<leader>ps', '<cmd>Copilot status<cr>', desc = 'Status'},
        {'<leader>pp', '<cmd>Copilot panel<cr>', desc = 'Panel'},
        {'<M-n>', '<Plug>(copilot-next)', mode = 'i'},
        {'<M-p>', '<Plug>(copilot-previous)', mode = 'i'},
        {'<M-q>', '<Plug>(copilot-dismiss)', mode = 'i'},
        {'<M-Space>', '<Plug>(copilot-suggest)', mode = 'i'},
        -- <M-CR> for confirming a suggestion is defined in plugins.cmp
    },
}

M.config = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""
    vim.api.nvim_set_hl(0, "CopilotSuggestion", {link = 'Substitute'})
end

return M
