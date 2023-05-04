local M = {
    'sainnhe/gruvbox-material',
    lazy = false,
}

M.config = function()
    vim.opt.termguicolors = true
    vim.g.gruvbox_material_palette = 'mix'
    vim.g.gruvbox_material_background = 'medium'
    vim.g.gruvbox_material_menu_selection_background = 'yellow'

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

    local highlights = {
        -- general
        PmenuSel = { bg = "#282C34", fg = "NONE" },
        Pmenu = { fg = "#C5CDD9", bg = "#22252A" },

        -- for plugins: cmp
        CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", fmt = "strikethrough" },
        CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE", fmt = "bold" },
        CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE", fmt = "bold" },
        CmpItemMenu = { fg = "#C792EA", bg = "NONE", fmt = "italic" },
        CmpItemKindField = { fg = "#EED8DA", bg = "#B5585F" },
        CmpItemKindProperty = { fg = "#EED8DA", bg = "#B5585F" },
        CmpItemKindEvent = { fg = "#EED8DA", bg = "#B5585F" },
        CmpItemKindCopilot = { fg = "#EED8DA", bg = "#B5585F" },
        CmpItemKindText = { fg = "#C3E88D", bg = "#9FBD73" },
        CmpItemKindEnum = { fg = "#C3E88D", bg = "#9FBD73" },
        CmpItemKindKeyword = { fg = "#C3E88D", bg = "#9FBD73" },
        CmpItemKindConstant = { fg = "#FFE082", bg = "#D4BB6C" },
        CmpItemKindConstructor = { fg = "#FFE082", bg = "#D4BB6C" },
        CmpItemKindReference = { fg = "#FFE082", bg = "#D4BB6C" },
        CmpItemKindFunction = { fg = "#EADFF0", bg = "#A377BF" },
        CmpItemKindStruct = { fg = "#EADFF0", bg = "#A377BF" },
        CmpItemKindClass = { fg = "#EADFF0", bg = "#A377BF" },
        CmpItemKindModule = { fg = "#EADFF0", bg = "#A377BF" },
        CmpItemKindOperator = { fg = "#EADFF0", bg = "#A377BF" },
        CmpItemKindVariable = { fg = "#C5CDD9", bg = "#7E8294" },
        CmpItemKindFile = { fg = "#C5CDD9", bg = "#7E8294" },
        CmpItemKindUnit = { fg = "#F5EBD9", bg = "#D4A959" },
        CmpItemKindSnippet = { fg = "#F5EBD9", bg = "#D4A959" },
        CmpItemKindFolder = { fg = "#F5EBD9", bg = "#D4A959" },
        CmpItemKindMethod = { fg = "#DDE5F5", bg = "#6C8ED4" },
        CmpItemKindValue = { fg = "#DDE5F5", bg = "#6C8ED4" },
        CmpItemKindEnumMember = { fg = "#DDE5F5", bg = "#6C8ED4" },
        CmpItemKindInterface = { fg = "#D8EEEB", bg = "#58B5A8" },
        CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
        CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },
    }

    for group, colors in pairs(highlights) do
        vim.api.nvim_command("hi " .. group .. " guifg=" .. colors.fg .. " guibg=" .. colors.bg .. " gui=" .. (colors.fmt or "NONE"))
    end
end

return M
