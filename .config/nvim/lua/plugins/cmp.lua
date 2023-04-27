local M = {
    'hrsh7th/nvim-cmp',
    event = 'VeryLazy',
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'dmitmel/cmp-cmdline-history',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-nvim-lsp-document-symbol',
        'hrsh7th/cmp-calc',
        'hrsh7th/cmp-emoji',
        'onsails/lspkind-nvim',
        'windwp/nvim-autopairs',
        'dmitmel/cmp-digraphs',
        'max397574/cmp-greek',
        'uga-rosa/cmp-dynamic',
        {
            'saadparwaiz1/cmp_luasnip',
            dependencies = {
                'L3MON4D3/LuaSnip',
            },
        },
    }
}

-- TODO add https://github.com/hrsh7th/cmp-git

M.config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')

    lspkind.init({
        symbol_map = {
            Copilot = '',
        },
    })

    local menu_types = {
        nvim_lua = '[Lua]',
        nvim_lsp = '[LSP]',
        path = '[Path]',
        luasnip = '[Snip]',
        buffer = '[Buf]',
        cmdline = '[Cmd]',
        cmdline_history = '[Hist]',
        cmp_git = '[Git]',
        digraphs = '[Dig]',
        calc = '[Calc]',
        copilot = '[Copilot]',
        emoji = '[Emoji]',
        greek = '[Greek]',
        dynamic = '[Cust]',
    }

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'copilot' },
            { name = 'nvim_lua' },
            { name = 'luasnip' },
            { name = 'path' },
            { name = 'emoji' },
            { name = 'greek' },
            { name = 'dynamic', trigger_characters = {':'} },
        }, {
            { name = 'buffer', keyword_length = 3 },
        }),
        formatting = {
            fields = { 'abbr', 'kind', 'menu' },
            format = lspkind.cmp_format({
                mode = 'symbol',
                menu = menu_types,
            }),
        },
        mapping = {
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-c>'] = cmp.mapping.complete(),
            ['<C-q>'] = cmp.mapping.abort(),
            ['<C-j>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
            ['<C-n>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end,
            ['<C-p>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end,
            ['<C-k>'] = cmp.mapping.complete({
                config = {
                    sources = {
                        { name = 'calc' }
                    }
                },
            }),
            ['<C-d>'] = cmp.mapping.complete({
                config = {
                    sources = {
                        { name = 'digraphs' }
                    }
                },
            }),
        },
    })

    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'nvim_lsp_document_symbol' },
            { name = 'buffer', max_item_count = 15, keyword_length = 2 },
            { name = 'path' },
            { name = 'cmdline_history', max_item_count = 10 },
        }),
    })
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' },
            { name = 'cmdline', option = { ignore_cmds = { 'Man', '!' }, }, },
            { name = 'cmdline_history', max_item_count = 10 },
        }),
    })

    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

    require("cmp_dynamic").register({
        { label = ":today", insertText = function() return os.date("%Y-%m-%d") end, },
        { label = ":today-de", insertText = function() return os.date("%d.%m.%Y") end, },
        { label = ":today-utc", insertText = function() return os.date("!%Y-%m-%d") end, },
        { label = ":now", insertText = function() return os.date("%H:%M:%S") end, },
        { label = ":now-timestamp", insertText = function() return os.date("%s") end, },
        { label = ":today-de-utc", insertText = function() return os.date("!%d.%m.%Y") end, },
        { label = ":now-utc", insertText = function() return os.date("!%H:%M:%S") end, },
        { label = ":now-timestamp-utc", insertText = function() return os.date("!%s") end, },
    })
end

return M
