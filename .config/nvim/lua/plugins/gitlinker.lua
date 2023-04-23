local M = {
    -- Create document URLs for Github & Co.
    'ruifm/gitlinker.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
}

M.keys = function()
    local util = require('plugins/util/gitlinker')
    local keys = {
        { '<leader>gy', util.yank, desc = 'Yank remote document URL with line number' },
        { '<leader>gY', util.yank_document, desc = 'Yank remote document URL' },
        { '<leader>go', util.open, desc = 'Open remote document URL with line number' },
        { '<leader>gO', util.open_document, desc = 'Open remote document URL' },
    }
    return keys
end

M.config = function()
    local gitlinker = require('gitlinker')
    local hosts = require('gitlinker.hosts')
    local util = require('plugins/util/gitlinker')

    local callbacks = {}
    for _, gitlab_url in ipairs(util.get_gitlab_hosts()) do
        callbacks[gitlab_url] = hosts.get_gitlab_type_url
    end

    gitlinker.setup({
        callbacks = callbacks
    })

end

return M
