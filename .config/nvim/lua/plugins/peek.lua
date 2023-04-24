local M = {
    'toppair/peek.nvim',
    build = 'deno task --quiet build:fast',
    ft = 'markdown',
}

M.config = function()
    require('peek').setup()
    -- Register <leader>P mapping only for markdown files
    vim.api.nvim_create_autocmd('FileType', {
        pattern = 'markdown',
        callback = function()
            vim.api.nvim_buf_set_keymap(0, 'n', '<leader>P', "", {
                callback = function()
                    local peek = require('peek')
                    if peek.is_open() then
                        peek.close()
                    else
                        peek.open()
                    end
                end,
                desc = 'Markdown preview',
                noremap = true,
                silent = true
            })
        end
    })
end

return M
