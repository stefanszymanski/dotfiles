local M = {
    {
        -- Auto create closing brackets and stuff
        'windwp/nvim-autopairs',
        event = 'VeryLazy',
    },
    {
        -- Live preview for substitution
        'markonm/traces.vim',
        event = 'VeryLazy',
    },
    {
        -- TypoScript support
        'stefanszymanski/vim.typoscript',
        event = 'VeryLazy',
    },
    {
        -- Puppet support
        'rodjek/vim-puppet',
        event = 'VeryLazy',
    }
}

return M
