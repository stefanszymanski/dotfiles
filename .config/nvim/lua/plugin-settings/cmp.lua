local M = {}

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
          },
        formatting = {
            format = lspkind.cmp_format {
                with_text = true,
                menu = {
                    nvim_lua = '[Lua]',
                    nvim_lsp = '[LSP]',
                    path = '[Path]',
                    luasnip = '[Snippet]',
                    buffer = '[Buffer]',
                    cmp_git = '[Git]',
                },
            },
        },

      mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end,
        ['<S-Tab>'] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end,
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      },
    }
end

return M
