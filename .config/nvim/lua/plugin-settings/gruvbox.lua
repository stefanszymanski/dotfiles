local M = {}

M.config = function()
    vim.opt.termguicolors = true
    vim.g.gruvbox_material_palette = 'mix'
    vim.g.gruvbox_material_background = 'medium'
    vim.cmd [[colorscheme gruvbox-material]]
end

return M
