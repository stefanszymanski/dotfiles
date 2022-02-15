local M = {}

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

M.config = function()
    local lualine = require('lualine')
    local gps = require('nvim-gps')
    local dap = require('dap')

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
            lualine_a = { 'mode' },
            lualine_b = {
                'branch',
                'diff',
                {
                  "diagnostics",
                  sources = { "nvim_diagnostic" },
                  symbols = { error = " ", warn = " ", info = " ", hint = " " },
                  colored = false,
                },
            },
            lualine_c = {
                {
                    lsp_client,
                    icon = "",
                    color = {fg = '#a9a1e1'},
                },
                {
                    gps.get_location,
                    cond = gps.is_available,
                    color = {fg = '#98be65'},
                },
                {
                    dap.status,
                    color = {fg = '#b51326'}
                },
            },
            lualine_x = { 'filename', 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
        },
        inactive_sections = {},
        tabline = {},
        extensions = {}
    }
end

return M
