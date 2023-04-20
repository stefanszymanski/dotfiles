local M = {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufRead',
    build = ':TSUpdate',
    dependencies = {
        {
            -- Status line
            'nvim-lualine/lualine.nvim',
            dependencies = { 'kyazdani42/nvim-web-devicons' },
            config = function() require('plugin-settings.lualine').config() end,
        },
        {
            -- Additional text objects
            'nvim-treesitter/nvim-treesitter-textobjects',
            config = function() require('plugin-settings.treesitter-textobjects').config() end,
        },
        {
            -- Swap list elements, e.g. arguments
            'mizlan/iswap.nvim',
            config = function() require('plugin-settings.iswap').config() end,
        },
        {
            -- Create HTML with a emmet like syntax
            'lukas-reineke/indent-blankline.nvim',
            config = function() require('plugin-settings.indent-blankline').config() end,
        },
        {
            -- Display LSP context in status line
            'SmiteshP/nvim-gps',
            config = function() require('nvim-gps').setup {} end,
        },
        {
            -- Diagnostics dashboard
            'folke/trouble.nvim',
            cmd = 'Trouble',
            dependencies = { 'kyazdani42/nvim-web-devicons' },
            config = function() require('plugin-settings.trouble').config() end,
        },
        {
            -- Toggle comments
            'numToStr/Comment.nvim',
            version = '*',
            dependencies = {
                'JoosepAlviste/nvim-ts-context-commentstring',
            },
            config = function() require('plugin-settings.comment').config() end,
        },
    }
}

M.config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = "all",
      highlight = {
        enable = true,
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = 'gnn',
          node_incremental = 'grn',
          scope_incremental = 'grc',
          node_decremental = 'grm',
        },
      },
      indent = {
        enable = true,
      },
    }
end

return M
