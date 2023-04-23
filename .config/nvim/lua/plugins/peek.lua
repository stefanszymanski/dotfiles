local M = {
    'toppair/peek.nvim',
    build = 'deno task --quiet build:fast',
    ft = 'markdown',
}

M.config = function()
    require('peek').setup()
end

return M
