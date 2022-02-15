local M = {}

M.config = function()
    local lspconfig = require('lspconfig')

    local on_attach = function(client, bufnr)
        local legendary = require('legendary')
        local whichkey = require('which-key')

        -- Highlight symbol occurences
        if client.resolved_capabilities.document_highlight then
            vim.cmd [[
                augroup lsp_document_highlight
                    autocmd! * <buffer>
                    autocmd! CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd! CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]]
        end

        -- Define key bindings
        local keymap_n = {}
        local keymap_v = {}

        if client.resolved_capabilities.rename then
            -- TODO remove transparency from input dialog
            keymap_n.lr = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename (suc)' }
        end
        if client.resolved_capabilities.call_hierarchy then
            keymap_n.li = { '<cmd>lua vim.lsp.buf.incoming_calls()<cr>', 'Incoming calls' }
            keymap_n.lo = { '<cmd>lua vim.lsp.buf.outgoing_calls()<cr>', 'Outgoing calls' }
        end
        if client.resolved_capabilities.document_formatting then
            keymap_n.lf = { '<cmd>lua vim.lsp.buf.formatting()<cr>', 'Format document' }
        end
        if client.resolved_capabilities.document_range_formatting then
            keymap_v.lf = { '<cmd>lua vim.lsp.buf.range_formatting()<cr>', 'Format' }
        end
        if client.resolved_capabilities.hover then
            legendary.bind_keymaps {
                { 'K', ':lua vim.lsp.buf.hover()<cr>', opts = { noremap = true, silent = true }, description = 'Show LSP hover information' }
            }
        end

        if next(keymap_n) then
            whichkey.register(keymap_n, { prefix = '<leader>', buffer = bufnr })
        end
        if next(keymap_v) then
            whichkey.register(keymap_v, { prefix = '<leader>', buffer = bufnr, mode = 'v' })
        end
    end

    -- Configure most languages
    local servers = {
        'awk_ls',
        'bashls',
        'cssls',
        'diagnosticls',
        'dockerls',
        'eslint',
        'jedi_language_server',
        'lemminx',
        'puppet',
        'rust_analyzer',
        'sqls',
        'texlab',
        'vimls',
    }

    for _, lsp in pairs(servers) do
        lspconfig[lsp].setup {
            on_attach = on_attach,
        }
    end

    -- Configure JSON
    lspconfig.jsonls.setup {
        on_attach = on_attach,
        settings = {
            json = {
                schemas = require('schemastore').json.schemas(),
            }
        }
    }

    -- Configure HTML
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    lspconfig.html.setup {
        capabilities = capabilities,
    }

    -- Configure PHP
    -- Formatting is disabled for both because it's done by null-ls.
    lspconfig.intelephense.setup {
        on_attach = function(client, bufnr)
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false
            on_attach(client, bufnr)
        end
    }

    -- Configure Lua
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    lspconfig.sumneko_lua.setup {
      on_attach = on_attach,
      cmd = { '/home/stefan/build/lua-language-server/bin/lua-language-server' },
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
            path = runtime_path,
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = {
            enable = false,
          },
        },
      },
    }

    -- -----------
    -- Diagnostics
    -- -----------

    vim.diagnostic.config {
        virtual_text = false,
        -- signs = true,
        -- underline = true,
        update_in_insert = true,
        -- severity_sort = false,
    }

    -- Display only errors as virtual text
    -- TODO does not work, always displays all diagnostics
    local original_set_virtual_text = vim.lsp.diagnostic.set_virtual_text
    local custom_set_virtual_text = function(diagnostics, bufnr, client_id, sign_ns, opts)
        opts = opts or {}
        -- opts.severity_limit = "Error"
        original_set_virtual_text(diagnostics, bufnr, client_id, sign_ns, opts)
    end
    vim.lsp.diagnostic.set_virtual_text = custom_set_virtual_text

    -- Display messages as notifications
    vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        local lvl = ({'ERROR', 'WARN', 'INFO', 'DEBUG'})[result.type]
        vim.notify({' ' .. result.message .. ' '}, lvl, {
            title = 'LSP | ' .. client.name,
            timeout = 10000,
            keep = function()
                return lvl == 'ERROR' or lvl == 'WARN'
            end,
        })
    end
end

return M
