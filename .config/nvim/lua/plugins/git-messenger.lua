local M = {
    -- Git blame popup
    'rhysd/git-messenger.vim',
    keys = {
        {'<leader>gb', ':GitMessenger', desc = 'Blame'},
    }
}

M.config = function()
    vim.g.git_messenger_no_default_mappings = 1
    vim.g.git_messenger_always_into_popup = 1
end

return M
