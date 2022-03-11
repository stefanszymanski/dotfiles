local M = {}

M.config = function()
    vim.opt.termguicolors = true
    vim.g.gruvbox_material_palette = 'mix'
    vim.g.gruvbox_material_background = 'medium'

    vim.cmd [[colorscheme gruvbox-material]]

    vim.cmd [[
        augroup CustomColors
            au!
            au ColorScheme * hi link VirtualTextError RedSign
            au ColorScheme * hi link VirtualTextWarning OrangeSign
            au ColorScheme * hi link VirtualTextInfo BlueSign
            au ColorScheme * hi link VirtualTextHint YellowSign
        augroup end
    ]]
end

return M
