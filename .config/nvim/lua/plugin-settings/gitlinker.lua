local M = {}

M.config = function()
    local gitlinker = require('gitlinker')
    local hosts = require('gitlinker.hosts')
    local whichkey = require('which-key')

    -- TODO move additional hosts elsewhere. See https://gitlab.com/AckslD/config/-/blob/b962c6f2af10fd41edae7f090f1442fc904f5010/nvim/lua/plugin_settings/gitlinker.lua
    gitlinker.setup {
        callbacks = {
            ["git.form4.de"] = hosts.get_gitlab_type_url,
        }
    }

    whichkey.register({
        gY = 'Yank remote document URL with line number',
        gy = {'<cmd>lua require"gitlinker".get_buf_range_url("n", {add_current_line_on_normal_mode = false})<cr>', 'Yank remote document URL'},
    }, {prefix = '<leader>'})
end

return M
