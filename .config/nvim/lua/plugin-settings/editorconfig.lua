local M = {}

M.config = function()
    vim.g.EditorConfig_exclude_patterns = { 'fugitive://.\\*' }
    vim.g.EditorConfig_max_line_indicator = 'line'
end

return M
