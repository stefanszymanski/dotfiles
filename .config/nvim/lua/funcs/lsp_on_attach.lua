local function on_attach(client, bufnr)
    local legendary = require('legendary')
    local whichkey = require('which-key')

    -- Highlight symbol occurences
    if client.server_capabilities.documentHighlightProvider then
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

    if client.server_capabilities.renameProvider then
        -- TODO remove transparency from input dialog
        keymap_n.lr = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename (suc)' }
    end
    if client.server_capabilities.callHierarchyProvider then
        keymap_n.lI = { '<cmd>lua vim.lsp.buf.incoming_calls()<cr>', 'Incoming calls' }
        keymap_n.lO = { '<cmd>lua vim.lsp.buf.outgoing_calls()<cr>', 'Outgoing calls' }
    end
    if client.server_capabilities.documentFormattingProvider then
        keymap_n.lf = { '<cmd>lua vim.lsp.buf.format({async = true})<cr>', 'Format document' }
    end
    if client.server_capabilities.documentRangeFormattingProvider then
        keymap_v.lf = { '<cmd>lua vim.lsp.buf.format({silent = true, buffer = 0, normal = true})<cr>', 'Format' }
    end
    if client.server_capabilities.hoverProvider then
        legendary.keymaps {
            { '-', ':lua vim.lsp.buf.hover()<cr>', opts = { noremap = true, silent = true }, description = 'Show LSP hover information' }
        }
    end

    if next(keymap_n) then
        whichkey.register(keymap_n, { prefix = '<leader>', buffer = bufnr })
    end
    if next(keymap_v) then
        whichkey.register(keymap_v, { prefix = '<leader>', buffer = bufnr, mode = 'v' })
    end
end

return on_attach
