local M = {}

M.config = function()
    local nullls = require('null-ls')

    local on_attach = function(client, bufnr)
        -- TODO this code is copied from lspconfig.lua, move it somewhere else, so it can be reused
        local whichkey = require('which-key')

        -- Define key bindings
        local keymap_n = {}
        local keymap_v = {}

        if client.resolved_capabilities.document_formatting then
            keymap_n.lf = { '<cmd>lua vim.lsp.buf.formatting()<cr>', 'Format document' }
        end
        if client.resolved_capabilities.document_range_formatting then
            keymap_v.lf = { '<cmd>lua vim.lsp.buf.range_formatting()<cr>', 'Format' }
        end

        if next(keymap_n) then
            whichkey.register(keymap_n, { prefix = '<leader>', buffer = bufnr })
        end
        if next(keymap_v) then
            whichkey.register(keymap_v, { prefix = '<leader>', buffer = bufnr, mode = 'v' })
        end
    end

    -- Formatters
    -- TODO add prettier
    -- TODO add typoscript-linter
    -- TODO add shfmt
    -- TODO add xmllint
    -- Linters
    -- TODO add editorconfig-checker
    -- TODO add luacheck
    -- TODO add phpcodesniffer, phpstan, psalm
    -- TODO add Stylelint
    -- TODO add texlint
    -- TODO add vimlint
    -- Code actions
    -- TODO add refactoring.nvim
    nullls.setup {
        on_attach = on_attach,
        save_after_format = false,
        debounce = 150,
        sources = {
            -- Formatters
            -- nullls.builtins.formatting.codespell, -- TODO disable per default, fix errors only on demand
            nullls.builtins.formatting.fixjson,
            nullls.builtins.formatting.phpcsfixer,
            nullls.builtins.formatting.sqlformat,
            -- Linters
            nullls.builtins.diagnostics.codespell, -- TODO why aren't errors linted, but fixed?
            nullls.builtins.diagnostics.eslint,
            nullls.builtins.diagnostics.gitlint,
            nullls.builtins.diagnostics.hadolint,
            nullls.builtins.diagnostics.markdownlint,
            nullls.builtins.diagnostics.proselint,
            nullls.builtins.diagnostics.shellcheck,
            -- nullls.builtins.diagnostics.vale,
            nullls.builtins.diagnostics.yamllint,
            nullls.builtins.diagnostics.zsh,
            -- Code actions
            nullls.builtins.code_actions.proselint,
            nullls.builtins.code_actions.shellcheck,
        }
    }
end

return M
