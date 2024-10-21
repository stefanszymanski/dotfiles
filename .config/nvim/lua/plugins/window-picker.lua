local M = {
    's1n7ax/nvim-window-picker',
    lazy = true,
}

M.config = function()
    require('window-picker').setup({
        filter_rules = {
            autoselect_one = true,
            include_current_win = true,
            -- filter using buffer options
            bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { 'neo-tree', "neo-tree-popup", "notify" },
                -- if the buffer type is one of following, the window will be ignored
                buftype = { 'terminal', "quickfix" },
            },
        },
    })
end

return M
