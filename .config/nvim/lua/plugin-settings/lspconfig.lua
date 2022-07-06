local M = {}

M.config = function()
    local lspconfig = require('lspconfig')
    local on_attach = require('funcs.lsp_on_attach')

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
        'sqlls',
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
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
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
        virtual_text = {
            prefix = ' ',
            -- Do not display the diagnostics source
            source = false,
            -- Display only errors as virtual text
            severity = 'Error'
        },
        signs = true,
        update_in_insert = true,
        severity_sort = true,
    }

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
