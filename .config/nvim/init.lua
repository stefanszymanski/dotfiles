-- " Plug 'tpope/vim-dispatch'
-- " Plug 'wellle/targets.vim'
-- " Plug 'lervag/vimtex'

-- require('polyfill.visual')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('settings')
require('lazy').setup({
    spec = {
        {
            'dstein64/vim-startuptime',
        },
        { import = 'plugins-old' },
        { import = 'plugins' },
    },
    performance = {
        rtp = {
          disabled_plugins = {
            'gzip',
            'matchit',
            'matchparen',
            'netrwPlugin',
            'tarPlugin',
            'tohtml',
            'tutor',
            'zipPlugin',
          },
        },
    }
})

require('keys')
