local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

-- Ensure packer is installed
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local packer_config = {
    -- opt_default = false,
    -- transitive_opt = true,
}

require('packer').startup({function(use)
    -- Packet manager
    use {
        'wbthomason/packer.nvim',
        config = function() require('plugin-settings.emmet').config() end,
    }

    -- View Neovim startup time information
    use 'dstein64/vim-startuptime'

    -- Search bindings and commands with vim.ui.select
    use {
        'mrjones2014/legendary.nvim',
        requires = {
            -- Display key bindings while typing
            {
                'folke/which-key.nvim',
                config = function() require('plugin-settings.which-key').config() end,
            }
        },
        config = function() require('plugin-settings.legendary').config() end,
    }

    -- --------------------
    -- Theme and appearance
    -- --------------------

    -- Gruvbox theme
    use {
        'sainnhe/gruvbox-material',
        config = function() require('plugin-settings.gruvbox').config() end,
    }

    -- Status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        after = 'nvim-treesitter',
        config = function() require('plugin-settings.lualine').config() end,
    }

    -- Fancier input and select
    use {
        'stevearc/dressing.nvim',
        config = function() require('plugin-settings.dressing').config() end,
    }

    -- Better wildmenu
    use {
        'gelguy/wilder.nvim',
        requires = {'romgrk/fzy-lua-native'},
        config = function() require('plugin-settings.wilder').config() end,
    }

    -- ------------------
    -- Session Management
    -- ------------------

    -- Manage sessions, identified by their root directory
    use {
        'rmagatti/auto-session',
        config = function() require('plugin-settings.auto-session').config() end,
        requires = {
            {
                -- List sessions with Telescope
                'rmagatti/session-lens',
                after = 'auto-session',
                requires = 'nvim-telescope/telescope.nvim',
                config = function() require('plugin-settings.session-lens').config() end,
            },
        },
    }

    -- ---------
    -- Utilities
    -- ---------

    -- Unified window movement and resizing for nvim and tmux
    use {
        'aserowy/tmux.nvim',
        config = function() require('plugin-settings.tmux').config() end,
    }
    
    -- Close a buffer without closing its window
    use {
        'ojroques/nvim-bufdel',
        config = function() require('plugin-settings.bufdel').config() end,
    }

    -- Quickly navigate to lines, word and characters
    use {
        'phaazon/hop.nvim',
        config = function() require('plugin-settings.hop').config() end,
    }

    -- Highlighting and easier repitition of f/F/t/T searches
    use {
        'rhysd/clever-f.vim',
        config = function() require('plugin-settings.clever-f').config() end,
    }

    -- Auto create closing brackets and stuff
    use {
        'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup{} end,
    }

    -- Better increment/decrement
    use {
        'monaqa/dial.nvim',
        keys = {'<C-a>', '<C-x>'},
        config = function() require('plugin-settings.dial').config() end,
    }

    -- TODO what does this plugin do?
    use 'antoinemadec/FixCursorHold.nvim'

    -- Terminal popup
    use {
        'numToStr/FTerm.nvim',
        config = function() require('plugin-settings.fterm').config() end
    }

    -- Notifications
    use {
        'rcarriga/nvim-notify',
        config = function() require('plugin-settings.notify').config() end
    }

    -- Undo history
    use {
        'simnalamburt/vim-mundo',
        config = function() require('plugin-settings.mundo').config() end,
    }
    -- Commands for basic filesystem actions
    use 'tpope/vim-eunuch'

    -- Bindings for en/disable/toggle features, en/decoding text, jumping
    use {
        'tpope/vim-unimpaired',
        requires = {
            {'tpope/vim-repeat', opt = true}
        },
        config = function() require('plugin-settings.unimpaired').config() end,
    }

    -- Improved search behaviour
    use 'junegunn/vim-slash'

    -- Live preview for substitution
    use 'markonm/traces.vim'

    -- Readline bindings in insert mode
    use 'tpope/vim-rsi'

    -- Highlight text with different colors
    use {
        'azabiong/vim-highlighter',
        config = function() require('plugin-settings.highlighter').config() end,
    }

    -- REST client
    use {
        "NTBBloodbath/rest.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function() require('plugin-settings.rest').config() end,
    }

    -- Better terminal integration
    use {
        'nikvdp/neomux',
        config = function() require('plugin-settings.neomux').config() end,
    }

    -- -------
    -- Editing
    -- -------

    -- Replace from register
    use {
        'svermeulen/vim-subversive',
        config = function() require('plugin-settings.subversive').config() end,
    }

    -- Change word casing
    use {
        'arthurxavierx/vim-caser',
        config = function() require('plugin-settings.caser').config() end,
    }

    -- Sort lines and lists
    use {
        'sQVe/sort.nvim',
        config = function() require('plugin-settings.sort').config() end,
    }

    -- Number conversion
    use {
        'glts/vim-radical',
        requires = {
            {'glts/vim-magnum'},
            {'tpope/vim-repeat', opt = true}
        },
        config = function() require('plugin-settings.radical').config() end,
    }

    -- Jump and resolve conflict markers
    use {
        'rhysd/conflict-marker.vim',
        config = function() require('plugin-settings.conflict-marker').config() end,
    }

    -- Toggle comments
    use {
        'numToStr/Comment.nvim',
        keys = {'g'},
        config = function() require('plugin-settings.comment').config() end,
    }

    -- Create, change, delete surroundings
    use {
        'tpope/vim-surround',
        config = function() require('plugin-settings.surround').config() end,
    }

   -- Swap list elements, e.g. arguments
    use {
        'mizlan/iswap.nvim',
        after = 'nvim-treesitter',
        config = function() require('plugin-settings.iswap').config() end,
    }

    -- Create HTML with a emmet like syntax
    use 'mattn/emmet-vim'

    -- --------------
    -- Visual helpers
    -- --------------

    -- Indentation guides
    use {
        'lukas-reineke/indent-blankline.nvim',
        after = 'nvim-treesitter',
        config = function() require('plugin-settings.indent-blankline').config() end,
    }

    -- Highlight color strings with their color
    use {
        'norcalli/nvim-colorizer.lua',
        config = function() require('plugin-settings.colorizer').config() end,
    }

    -- ------------------
    -- Files and projects
    -- ------------------

    -- File browser
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function() require('plugin-settings.nvimtree').config() end
    }

    -- ---------
    -- Searching
    -- ---------

    use {
        'nvim-telescope/telescope.nvim',
        config = function() require('plugin-settings.telescope').config() end,
        requires = {
            {'nvim-lua/plenary.nvim'},
            {
                -- Use fzf for searching
                'nvim-telescope/telescope-fzf-native.nvim',
                after = 'telescope.nvim',
                run = 'make',
                config = function() require('telescope').load_extension('fzf') end,
            },
            {
                -- Browse and preview media files
                'nvim-telescope/telescope-media-files.nvim',
                requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' },
                after = 'telescope.nvim',
                config = function() require('plugin-settings.telescope-media-files').config() end,
            },
            {
                -- Browse and insert Unicode symbols
                'nvim-telescope/telescope-symbols.nvim',
                after = 'telescope.nvim',
                config = function() require('plugin-settings.telescope-symbols').config() end,
            },
            {
                -- Browse headings
                -- TODO restrict to certain filetypes
                'crispgm/telescope-heading.nvim',
                after = 'telescope.nvim',
                config = function() require('plugin-settings.telescope-heading').config() end,
            },
            {
                -- Browse local vcs repositories
                'cljoly/telescope-repo.nvim',
                after = 'telescope.nvim',
                config = function() require('plugin-settings.telescope-repo').config() end,
            },
            {
                -- File browser, displays one directory at a time
                'nvim-telescope/telescope-file-browser.nvim',
                after = 'telescope.nvim',
                config = function() require('plugin-settings.telescope-file-browser').config() end,
            },
            {
                -- List files from the arglist
                'jgvw/telescope-arglist.nvim',
                after = 'telescope.nvim',
                config = function() require('plugin-settings.telescope-arglist').config() end,
            },
            {
                -- Navigate in telescope with hop like motions
                'nvim-telescope/telescope-hop.nvim',
                after = 'telescope.nvim',
                config = function() require('plugin-settings.telescope-hop').config() end,
            }
        }
    }

    -- ---------------
    -- Version control
    -- ---------------

    -- Vim commands for git
    use {
        'tpope/vim-fugitive',
        config = function() require('plugin-settings.fugitive').config() end,
    }

    -- Git decorations
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function() require('plugin-settings.gitsigns').config() end,
    }

    -- Git blame popup
    use {
        'rhysd/git-messenger.vim',
        config = function() require('plugin-settings.git-messenger').config() end,
    }

    -- Diff view
    use {
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function() require('plugin-settings.diffview').config() end,
    }

    -- Create document URLs for Github & Co.
    use {
        'ruifm/gitlinker.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function() require('plugin-settings.gitlinker').config() end,
    }

    -- --------
    -- Snippets
    -- --------

    use 'L3MON4D3/LuaSnip'

    -- ----------
    -- Completion
    -- ----------

    -- Completion framework
    use {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        config = function() require('plugin-settings.cmp').config() end,
        requires = {
            -- TODO add comments about the purpose of each plugin
            { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
            -- Completion source: LSP
            { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
            -- Completion source: snippets from luasnip
            { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
            -- Show a symbol for the completion sources
            { 'onsails/lspkind-nvim', module = 'lspkind' },
        }
    }

    -- ----------------
    -- Language Support
    -- ----------------

    -- Semantic syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufRead',
        run = ':TSUpdate',
        config = function() require('plugin-settings.treesitter').config() end,
        requires = {
            -- Additional text objects
            {
                'nvim-treesitter/nvim-treesitter-textobjects',
                after = 'nvim-treesitter',
                config = function() require('plugin-settings.treesitter-textobjects').config() end,
            },
        }
    }

    -- Display LSP context in status line
    use {
        'SmiteshP/nvim-gps',
        after = "nvim-treesitter",
        config = function() require('nvim-gps').setup {} end,
    }

    -- Language Server Protocol configurations
    use {
        'neovim/nvim-lspconfig',
        event = 'BufReadPre',
        requires = {
            'b0o/schemastore.nvim',
        },
        config = function() require('plugin-settings.lspconfig').config() end,
    }

    -- LSP client integration for non-LSP tools
    use {
        'jose-elias-alvarez/null-ls.nvim',
        event = 'BufReadPre',
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require('plugin-settings.null-ls').config() end,
    }

    -- Display the LSP indexing progress in the lower right corner
    use {
        'j-hui/fidget.nvim',
        config = function() require('fidget').setup {
            text = {
                spinner = 'dots'
            }
        } end,
    }

    -- Show function signature while typing
    use {
        'ray-x/lsp_signature.nvim',
        config = function() require('plugin-settings.lsp-signature').config() end,
    }

    -- Diagnostics dashboard
    use {
        'folke/trouble.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        after = 'telescope.nvim',
        config = function() require('plugin-settings.trouble').config() end,
    }

    -- Debugger Adapter Protocol client
    use {
        'mfussenegger/nvim-dap',
        config = function() require('plugin-settings.dap').config() end,
        requires = {
            {
                'rcarriga/nvim-dap-ui',
                after = 'nvim-dap',
                config = function() require('plugin-settings.dapui').config() end,
            },
            {
                'nvim-telescope/telescope-dap.nvim',
                after = 'nvim-dap',
                config = function() require('telescope').load_extension('dap') end,
            },
            {
                'theHamsta/nvim-dap-virtual-text',
                after = 'nvim-dap',
                config = function() require('plugin-settings.dap-virtual-text').config() end,
            },
            {
                'Pocco81/DAPInstall.nvim',
                after = 'nvim-dap',
            }
        }
    }

    -- Display a hint when LSP code actions are available
    use {
        'kosayoda/nvim-lightbulb',
        config = function() require('plugin-settings.lightbulb').config() end,
    }

    -- Editor config support
    use {
        'editorconfig/editorconfig-vim',
        config = function() require('plugin-settings.editorconfig').config() end,
    }

    -- LSP call hierarchy view
    use {
        'ldelossa/litee-calltree.nvim',
        requires = {'ldelossa/litee.nvim'},
        config = function()
            require('litee.lib').setup{}
            require('litee.calltree').setup{}
        end
    }

    -- Markdown live preview in browser
    use {
        'iamcco/markdown-preview.nvim',
        config = function() require('plugin-settings.markdown-preview').config() end
    }

    -- Syntax highlighting
    use 'stefanszymanski/vim.typoscript'
    use 'rodjek/vim-puppet'

    if packer_bootstrap then
        require('packer').sync()
    end
end, config = packer_config})
