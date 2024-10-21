local M = {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufReadPre',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
}

M.config = function()
    local nullls = require('null-ls')
    local on_attach = require('funcs.lsp_on_attach')

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
    nullls.setup({
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
            -- nullls.builtins.diagnostics.codespell, -- TODO why aren't errors linted, but fixed?
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
    })
end

return M
