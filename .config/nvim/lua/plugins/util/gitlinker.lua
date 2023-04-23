local M = {}

M.get_gitlab_hosts = function()
    local file = vim.fn.expand('~/.config/nvim/local/gitlinker-gitlab-hosts')
    local has_gitlab_urls, gitlab_urls = pcall(vim.fn.readfile, file)
    if has_gitlab_urls then
        return gitlab_urls
    else
        return {}
    end
end

M.yank = function()
    return require('gitlinker').get_buf_range_url()
end

M.yank_document = function()
    local opts = { add_current_line_on_normal_mode = false }
    return require('gitlinker').get_buf_range_url('n', opts)
end

M.open = function()
    local actions = require('gitlinker.actions')
    local opts = { action_callback = actions.open_in_browser }
    return require('gitlinker').get_buf_range_url('n', opts)
end

M.open_document = function()
    local actions = require('gitlinker.actions')
    local opts = {
        add_current_line_on_normal_mode = false,
        action_callback = actions.open_in_browser
    }
    return require('gitlinker').get_buf_range_url('n', opts)
end

return M
