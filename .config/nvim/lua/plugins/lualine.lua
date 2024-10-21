local M = {
    'nvim-lualine/lualine.nvim',
    event = "BufReadPost",
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
        {
            -- Display LSP context in status line
            'SmiteshP/nvim-navic',
            dependencies = {
                'neovim/nvim-lspconfig',
            },
            config = function()
                require('nvim-navic').setup({
                    lsp = {
                        auto_attach = true,
                    },
                })
            end,
        },
    },
}

M.config = function()
    local lualine = require('lualine')
    local theme = require('lualine.themes.gruvbox-material')
    local navic = require('nvim-navic')

    local function lsp_client(msg)
        msg = msg or ""
        local buf_clients = vim.lsp.buf_get_clients()
        if next(buf_clients) == nil then
            if type(msg) == "boolean" or #msg == 0 then
                return ""
            end
            return ""
        end

        local buf_ft = vim.bo.filetype
        local buf_client_names = {}

        -- add client
        for _, client in pairs(buf_clients) do
            if client.name ~= "null-ls" then
                table.insert(buf_client_names, client.name)
            end
        end

        local s = require('null-ls.sources')
        local available_sources = s.get_available(buf_ft)
        for _, source in ipairs(available_sources) do
            table.insert(buf_client_names, source.name)
        end

        -- TODO remove duplicates from `buf_client_names`
        return table.concat(buf_client_names, ", ")
    end

    local function window()
        return vim.api.nvim_win_get_number(0)
    end

    -- define highlights for the diagnostics section
    local function register_diagnostic_highlights(bg)
        for _, kind in pairs({ 'Error', 'Warn', 'Info', 'Hint' }) do
            local hl = vim.api.nvim_get_hl_by_name('DiagnosticSign' .. kind, true)
            hl['bg'] = bg
            vim.api.nvim_set_hl(0, 'LualineDiagnostic' .. kind, hl)
        end
    end

    register_diagnostic_highlights(theme.normal.c.bg)

    local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { 'error', 'warn', 'info', 'hint' },
        symbols = {
            error = " ",
            warn = " ",
            info = " ",
            hint = " "
        },
        diagnostics_color = {
            error = 'LualineDiagnosticError',
            warn = 'LuaLineDiagnosticWarn',
            info = 'LuaLineDiagnosticInfo',
            hint = 'LuaLineDiagnosticHint',
        },
        colored = true,
        update_in_insert = false,
        always_visible = false,
    }

    lualine.setup {
        options = {
            theme = theme,
            icons_enabled = true,
            component_separators = { left = '|', right = '|' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {},
            always_divide_middle = true,
        },
        sections = {
            lualine_a = {
                window,
                'mode'
            },
            lualine_b = {
                'branch',
                'diff',
            },
            lualine_c = {
                diagnostics,
                {
                    lsp_client,
                    icon = "",
                    color = { fg = '#a9a1e1' },
                },
                {
                    navic.get_location,
                    cond = navic.is_available,
                    color = { fg = '#98be65' },
                },
                {
                    'dap',
                    color = { fg = '#b51326' }
                },
            },
            lualine_x = { 'filename', 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
        },
        inactive_sections = {
            lualine_a = { window },
        },
        tabline = {},
        extensions = {}
    }
end

return M
