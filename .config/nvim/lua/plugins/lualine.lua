local M = {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
        {
            -- Display LSP context in status line
            'SmiteshP/nvim-gps',
            config = function()
                require('nvim-gps').setup {}
            end,
        },
    },
    event = 'VeryLazy',
}

M.config = function()
    local lualine = require('lualine')
    -- local dap = require('dap')

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

        return "[" .. table.concat(buf_client_names, ", ") .. "]"
    end

    local function window()
        return vim.api.nvim_win_get_number(0)
    end

    local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
        colored = false,
    }

    lualine.setup {
        options = {
            theme = 'auto',
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
                diagnostics
            },
            lualine_c = {
                {
                    lsp_client,
                    icon = "",
                    color = { fg = '#a9a1e1' },
                },
                {
                    require('nvim-gps').get_location,
                    cond = require('nvim-gps').is_available,
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
