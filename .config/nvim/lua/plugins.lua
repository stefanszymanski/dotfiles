return {
    -- View Neovim startup time information
    'dstein64/vim-startuptime',

    -- Search bindings and commands with vim.ui.select
    {
        'mrjones2014/legendary.nvim',
        dependencies = {
            -- Display key bindings while typing
            {
                'folke/which-key.nvim',
                config = function() require('plugin-settings.which-key').config() end,
            }
        },
        config = function() require('plugin-settings.legendary').config() end,
    },

    -- --------------------
    -- Theme and appearance
    -- --------------------

    -- Gruvbox theme
    {
        'sainnhe/gruvbox-material',
        config = function() require('plugin-settings.gruvbox').config() end,
    },


    -- Fancier input and select
    {
        'stevearc/dressing.nvim',
        config = function() require('plugin-settings.dressing').config() end,
    },

    -- Better wildmenu
    {
        'gelguy/wilder.nvim',
        dependencies = {'romgrk/fzy-lua-native'},
        config = function() require('plugin-settings.wilder').config() end,
    },

    -- ------------------
    -- Session Management
    -- ------------------

    -- Manage sessions, identified by their root directory
    {
        'rmagatti/auto-session',
        config = function() require('plugin-settings.auto-session').config() end,
        dependencies = {
            {
                -- List sessions with Telescope
                'rmagatti/session-lens',
                dependencies = 'nvim-telescope/telescope.nvim',
                config = function() require('plugin-settings.session-lens').config() end,
            },
        },
    },

    -- ---------
    -- Utilities
    -- ---------

    -- Unified window movement and resizing for nvim and tmux
    {
        'aserowy/tmux.nvim',
        config = function() require('plugin-settings.tmux').config() end,
    },
    
    -- Close a buffer without closing its window
    {
        'ojroques/nvim-bufdel',
        config = function() require('plugin-settings.bufdel').config() end,
    },

    -- Quickly navigate to lines, word and characters
    {
        'phaazon/hop.nvim',
        config = function() require('plugin-settings.hop').config() end,
    },

    -- Highlighting and easier repitition of f/F/t/T searches
    {
        'rhysd/clever-f.vim',
        config = function() require('plugin-settings.clever-f').config() end,
    },

    -- Auto create closing brackets and stuff
    {
        'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup{} end,
    },

    -- Better increment/decrement
    {
        'monaqa/dial.nvim',
        keys = {'<C-a>', '<C-x>'},
        config = function() require('plugin-settings.dial').config() end,
    },

    -- TODO what does this plugin do?
    {
        'numToStr/FTerm.nvim',
        config = function() require('plugin-settings.fterm').config() end
    },

    -- Notifications
    {
        'rcarriga/nvim-notify',
        config = function() require('plugin-settings.notify').config() end
    },

    -- Undo history
    {
        'simnalamburt/vim-mundo',
        config = function() require('plugin-settings.mundo').config() end,
    },
    -- Commands for basic filesystem actions
    'tpope/vim-eunuch',

    -- Bindings for en/disable/toggle features, en/decoding text, jumping
    {
        'tpope/vim-unimpaired',
        dependencies = {
            {'tpope/vim-repeat'}
        },
        config = function() require('plugin-settings.unimpaired').config() end,
    },

    -- Improved search behaviour
    'junegunn/vim-slash',

    -- Live preview for substitution
    'markonm/traces.vim',

    -- Readline bindings in insert mode
    'tpope/vim-rsi',

    -- Highlight text with different colors
    {
        'azabiong/vim-highlighter',
        config = function() require('plugin-settings.highlighter').config() end,
    },

    -- REST client
    {
        "NTBBloodbath/rest.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function() require('plugin-settings.rest').config() end,
    },

    -- Better terminal integration
    {
        'nikvdp/neomux',
        config = function() require('plugin-settings.neomux').config() end,
    },

    -- -------
    -- Editing
    -- -------

    -- Replace from register
    {
        'svermeulen/vim-subversive',
        config = function() require('plugin-settings.subversive').config() end,
    },

    -- Change word casing
    {
        'arthurxavierx/vim-caser',
        config = function() require('plugin-settings.caser').config() end,
    },

    -- Sort lines and lists
    {
        'sQVe/sort.nvim',
        config = function() require('plugin-settings.sort').config() end,
    },

    -- Number conversion
    {
        'glts/vim-radical',
        dependencies = {
            {'glts/vim-magnum'},
            {'tpope/vim-repeat'}
        },
        config = function() require('plugin-settings.radical').config() end,
    },

    -- Jump and resolve conflict markers
    {
        'rhysd/conflict-marker.vim',
        config = function() require('plugin-settings.conflict-marker').config() end,
    },

    -- Toggle comments
    {
        'numToStr/Comment.nvim',
        keys = {'g'},
        config = function() require('plugin-settings.comment').config() end,
    },

    -- Create, change, delete surroundings
    {
        'tpope/vim-surround',
        config = function() require('plugin-settings.surround').config() end,
    },


    -- Highlight color strings with their color
    {
        'norcalli/nvim-colorizer.lua',
        config = function() require('plugin-settings.colorizer').config() end,
    },

    -- ------------------
    -- Files and projects
    -- ------------------

    -- File browser
    {
        'kyazdani42/nvim-tree.lua',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        config = function() require('plugin-settings.nvimtree').config() end
    },

    -- ---------
    -- Searching
    -- ---------

    {
        'nvim-telescope/telescope.nvim',
        config = function() require('plugin-settings.telescope').config() end,
        dependencies = {
            {'nvim-lua/plenary.nvim'},
            {
                -- Use fzf for searching
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                config = function() require('telescope').load_extension('fzf') end,
            },
            {
                -- Browse and preview media files
                'nvim-telescope/telescope-media-files.nvim',
                dependencies = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' },
                config = function() require('plugin-settings.telescope-media-files').config() end,
            },
            {
                -- Browse and insert Unicode symbols
                'nvim-telescope/telescope-symbols.nvim',
                config = function() require('plugin-settings.telescope-symbols').config() end,
            },
            {
                -- Browse headings
                -- TODO restrict to certain filetypes
                'crispgm/telescope-heading.nvim',
                config = function() require('plugin-settings.telescope-heading').config() end,
            },
            {
                -- Browse local vcs repositories
                'cljoly/telescope-repo.nvim',
                config = function() require('plugin-settings.telescope-repo').config() end,
            },
            {
                -- File browser, displays one directory at a time
                'nvim-telescope/telescope-file-browser.nvim',
                config = function() require('plugin-settings.telescope-file-browser').config() end,
            },
            {
                -- Navigate in telescope with hop like motions
                'nvim-telescope/telescope-hop.nvim',
                config = function() require('plugin-settings.telescope-hop').config() end,
            }
        }
    },

    -- ---------------
    -- Version control
    -- ---------------

    -- Vim commands for git
    {
        'tpope/vim-fugitive',
        config = function() require('plugin-settings.fugitive').config() end,
    },

    -- Git decorations
    {
        'lewis6991/gitsigns.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function() require('plugin-settings.gitsigns').config() end,
    },

    -- Git blame popup
    {
        'rhysd/git-messenger.vim',
        config = function() require('plugin-settings.git-messenger').config() end,
    },

    -- Diff view
    {
        'sindrets/diffview.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function() require('plugin-settings.diffview').config() end,
    },

    -- Create document URLs for Github & Co.
    {
        'ruifm/gitlinker.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function() require('plugin-settings.gitlinker').config() end,
    },

    -- --------
    -- Snippets
    -- --------

    'L3MON4D3/LuaSnip',

    -- ----------
    -- Completion
    -- ----------

    -- Completion framework
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        config = function() require('plugin-settings.cmp').config() end,
        dependencies = {
            -- TODO add comments about the purpose of each plugin
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            -- Completion source: LSP
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            -- Completion source: snippets from luasnip
            { 'saadparwaiz1/cmp_luasnip' },
            -- Show a symbol for the completion sources
            { 'onsails/lspkind-nvim', module = 'lspkind' },
        }
    },

    -- ----------------
    -- Language Support
    -- ----------------

    -- Semantic syntax highlighting
    {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufRead',
        build = ':TSUpdate',
        config = function() require('plugin-settings.treesitter').config() end,
        dependencies = {
            -- Status line
            {
                'nvim-lualine/lualine.nvim',
                dependencies = { 'kyazdani42/nvim-web-devicons' },
                config = function() require('plugin-settings.lualine').config() end,
            },
            -- Additional text objects
            {
                'nvim-treesitter/nvim-treesitter-textobjects',
                config = function() require('plugin-settings.treesitter-textobjects').config() end,
            },
            -- Swap list elements, e.g. arguments
            {
                'mizlan/iswap.nvim',
                config = function() require('plugin-settings.iswap').config() end,
            },
            -- Create HTML with a emmet like syntax
            {
                'lukas-reineke/indent-blankline.nvim',
                config = function() require('plugin-settings.indent-blankline').config() end,
            },
            -- Display LSP context in status line
            {
                'SmiteshP/nvim-gps',
                config = function() require('nvim-gps').setup {} end,
            },
            -- Diagnostics dashboard
            {
                'folke/trouble.nvim',
                dependencies = { 'kyazdani42/nvim-web-devicons' },
                config = function() require('plugin-settings.trouble').config() end,
            },
        }
    },


    -- Language Server Protocol configurations
    {
        'neovim/nvim-lspconfig',
        event = 'BufReadPre',
        dependencies = {
            'b0o/schemastore.nvim',
        },
        config = function() require('plugin-settings.lspconfig').config() end,
    },

    -- LSP client integration for non-LSP tools
    {
        'jose-elias-alvarez/null-ls.nvim',
        event = 'BufReadPre',
        dependencies = {'nvim-lua/plenary.nvim'},
        config = function() require('plugin-settings.null-ls').config() end,
    },

    -- Display the LSP indexing progress in the lower right corner
    {
        'j-hui/fidget.nvim',
        config = function() require('fidget').setup {
            text = {
                spinner = 'dots'
            }
        } end,
    },

    -- Show function signature while typing
    {
        'ray-x/lsp_signature.nvim',
        config = function() require('plugin-settings.lsp-signature').config() end,
    },


    -- Debugger Adapter Protocol client
    {
        'mfussenegger/nvim-dap',
        config = function() require('plugin-settings.dap').config() end,
        dependencies = {
            {
                'rcarriga/nvim-dap-ui',
                config = function() require('plugin-settings.dapui').config() end,
            },
            -- {
            --     'nvim-telescope/telescope-dap.nvim',
            --     config = function() require('telescope').load_extension('dap') end,
            -- },
            {
                'theHamsta/nvim-dap-virtual-text',
                config = function() require('plugin-settings.dap-virtual-text').config() end,
            },
            {
                'Pocco81/DAPInstall.nvim',
            }
        }
    },

    -- Display a hint when LSP code actions are available
    {
        'kosayoda/nvim-lightbulb',
        config = function() require('plugin-settings.lightbulb').config() end,
    },

    -- Editor config support
    {
        'editorconfig/editorconfig-vim',
        config = function() require('plugin-settings.editorconfig').config() end,
    },

    -- LSP call hierarchy view
    {
        'ldelossa/litee-calltree.nvim',
        dependencies = {'ldelossa/litee.nvim'},
        config = function()
            require('litee.lib').setup{}
            require('litee.calltree').setup{}
        end
    },

    -- Markdown live preview in browser
    {
        'iamcco/markdown-preview.nvim',
        config = function() require('plugin-settings.markdown-preview').config() end
    },

    -- Syntax highlighting
    'stefanszymanski/vim.typoscript',
    'rodjek/vim-puppet',
}
