local M = {
    'hrsh7th/nvim-cmp',
    event = 'VeryLazy',
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-nvim-lsp-document-symbol',
        'onsails/lspkind-nvim',
        {
            'saadparwaiz1/cmp_luasnip',
            dependencies = {
                'L3MON4D3/LuaSnip',
            },
        },
    }
}

M.config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')
    cmp.setup {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        sources = {
            { name = 'path' },
            { name = 'buffer' },
            { name = 'nvim_lua' },
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'nvim_lsp_signature_help' },
        },
        formatting = {
            format = lspkind.cmp_format {
                with_text = true,
                menu = {
                    nvim_lua = '[Lua]',
                    nvim_lsp = '[LSP]',
                    path = '[Path]',
                    luasnip = '[Snip]',
                    buffer = '[Buf]',
                    cmp_git = '[Git]',
                },
            },
        },
        mapping = {
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-q>'] = cmp.mapping.close(),
            ['<C-CR>'] = cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            },
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
            ['<M-CR>'] = function(fallback)
                -- see plugins/copilot.lua
                local copilot_keys = vim.fn["copilot#Accept"]()
                if copilot_keys ~= "" then
                    vim.api.nvim_feedkeys(copilot_keys, "i", true)
                else
                    fallback()
                end
            end
        },
    }
    cmp.setup.cmdline({'/', '?'}, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' },
            { name = 'nvim_lsp_document_symbol' },
        },
    })
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' },
        }, {
            { name = 'cmdline' },
        }),
    })
end

return M
