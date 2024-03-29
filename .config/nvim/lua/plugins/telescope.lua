local function lsp_document_methods()
    require('telescope.builtin').lsp_document_symbols { symbols = 'method' }
end

local function project_files()
    local opts = {} -- define here if you want to define something
    local ok = pcall(require 'telescope.builtin'.git_files, opts)
    if not ok then require 'telescope.builtin'.find_files(opts) end
end

local function buffer_previewer_maker(filepath, bufnr, opts)
    local previewers = require('telescope.previewers')
    opts = opts or {}
    filepath = vim.fn.expand(filepath)
    vim.loop.fs_stat(filepath, function(_, stat)
        if not stat then return end
        if stat.size > 100000 then
            return
        else
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
        end
    end)
end

local M = {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-lua/popup.nvim',
        's1n7ax/nvim-window-picker',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
        },
    },
    cmd = 'Telescope',
    keys = {
        { '<leader>F', ':Telescope resume<CR>', desc = 'Resume latest search' },
        { '<leader>ff', project_files, desc = 'Files in workspace' },
        { '<leader>fb', ':Telescope current_buffer_fuzzy_find<CR>', desc = 'In current buffer' },
        { '<leader>fg', ':Telescope live_grep<CR>', desc = 'In workspace' },
        { '<leader>fr', ':Telescope oldfiles<CR>', desc = 'Recent files' },
        { '<leader>fs', ':Telescope search_history<CR>', desc = 'Search history' },
        { '<leader>fc', ':Telescope command_history<CR>', desc = 'Command history' },
        { '<leader>fw', ':Telescope grep_string<CR>', desc = 'Word in workspace' },
        { '<leader>fh', ':Telescope help_tags<CR>', desc = 'Help tags' },
        { '<leader>la', function() vim.lsp.buf.code_action() end, desc = 'Code actions' },
        { '<leader>lj', ':Telescope lsp_definitions<CR>', desc = 'Definitions' },
        { '<leader>li', ':Telescope lsp_implementations<CR>', desc = 'Implementations' },
        { '<leader>lt', ':Telescope lsp_type_definitions<CR>', desc = 'Type definitions' },
        { '<leader>ls', ':Telescope lsp_document_symbols<CR>', desc = 'Symbols in current buffer' },
        { '<leader>lS', ':Telescope lsp_dynamic_workspace_symbols<CR>', desc = 'Symbols in workspace' },
        { '<leader>lx', ':Telescope treesitter<CR>', desc = 'Treesitter symbols in current buffer' },
        { '<leader>lm', lsp_document_methods, desc = 'Symbols in current buffer' },
        { '<leader>gB', ':Telescope git_branches<CR>', desc = 'Branches' },
        { '<leader>gc', ':Telescope git_commits<CR>', desc = 'Commits' },
        { '<leader>gs', ':Telescope git_status<CR>', desc = 'Changed files' },
        { '<leader>gt', ':Telescope git_stash<CR>', desc = 'Stash' },
        { '<leader>bb', ':Telescope buffers<CR>', desc = 'List open' },
    },
}

M.config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local actions_layout = require('telescope.actions.layout')

    telescope.setup({
      defaults = {
        buffer_previewer_maker = buffer_previewer_maker,
        -- select window to open a file in
        get_selection_window = function()
            return require('window-picker').pick_window() or vim.api.nvim_get_current_win()
        end,
        sorting_strategy = 'ascending',
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--trim'
        },
        mappings = {
          i = {
            ['<esc>'] = actions.close,
            ['<M-p>'] = actions_layout.toggle_preview,
          },
          n = {
            ['<M-p>'] = actions_layout.toggle_preview,
          },
        },
        layout_config = {
          vertical = { prompt_position = 'top' },
        },
        layout_strategy = 'vertical'
      },
      pickers = {
        lsp_code_actions = {
            theme = 'cursor'
        },
        lsp_range_code_actions = {
            theme = 'cursor'
        },
      },
    })

    telescope.load_extension('fzf')
end

return M
