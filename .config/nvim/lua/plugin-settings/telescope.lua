local M = {}

M.config = function()
    local telescope = require('telescope')
    local extras = require('plugin-extras.telescope')
    local actions = require('telescope.actions')
    local actions_layout = require('telescope.actions.layout')
    local whichkey = require('which-key')

    telescope.setup {
      defaults = {
        buffer_previewer_maker = extras.buffer_previewer_maker,
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
          vertical = {prompt_position = 'top'},
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
    }

    whichkey.register({
        F = {':Telescope resume<cr>',                              'Resume latest search'},
        f = {
            f = {extras.project_files,                                 'Files in workspace'},
            b = {':Telescope current_buffer_fuzzy_search<cr>',         'In current buffer'},
            g = {':Telescope live_grep<cr>',                           'In workspace'},
            r = {':Telescope oldfiles<cr>',                            'Recent files'},
            s = {':Telescope search_history<cr>',                      'Search history'},
            c = {':Telescope command_history<cr>',                     'Command history'},
            w = {':Telescope grep_string<cr>',                         'Word in workspace'},
        },
        l = {
            a = {':Telescope lsp_code_actions<cr>',                    'Code actions'},
            j = {':Telescope lsp_definitions<cr>',                     'Definitions'},
            i = {':Telescope lsp_implementations<cr>',                 'Implementations'},
            t = {':Telescope lsp_type_definitions<cr>',                'Type definitions'},
            s = {':Telescope lsp_document_symbols<cr>',                'Symbols in current buffer'},
            S = {':Telescope lsp_workspace_symbols<cr>',               'Symbols in workspace'},
            x = {':Telescope treesitter<cr>',                          'Treesitter symbols in current buffer'},
        },
        g = {
            B = {':Telescope git_branches<cr>',                        'Branches'},
            c = {':Telescope git_commits<cr>',                         'Commits'},
            s = {':Telescope git_status<cr>',                          'Changed files'},
            t = {':Telescope git_stash<cr>',                           'Stash'},
        },
        b = {
            b = {':Telescope buffers<cr>',                             'List open'},
        },
    }, {prefix = '<leader>'})

    whichkey.register({
        l = {
            a = {[[:'<,'>Telescope lsp_range_code_actions<cr>]],       'Code actions'},
        },

    }, {prefix = '<leader>', mode = 'v'})
end

return M
