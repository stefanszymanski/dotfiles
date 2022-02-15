local M = {}

M.config = function()
    local augend = require('dial.augend')
    local dial = require('dial.config')
    local legendary = require('legendary')

    dial.augends:register_group {
        default = {
            augend.integer.alias.decimal_int,
            augend.integer.alias.hex,
            augend.integer.alias.octal,
            augend.integer.alias.binary,
            augend.constant.alias.bool,
            augend.date.alias["%Y-%m-%d"],
            augend.date.alias["%H:%M:%S"],
            augend.date.alias["%H:%M"],
            augend.semver.alias.semver,
            augend.constant.new {
                elements = {'private', 'protected', 'public'},
                word = true,
                cyclic = true,
            },
            augend.constant.new {
                elements = {'&&', '||'},
                word = false,
                cyclic = true,
            },
        }
    }

    local opts = {silent = true, noremap = false}
    legendary.bind_keymaps {
        {'<C-a>', '<Plug>(dial-increment)', opts = opts, mode = 'n'},
        {'<C-x>', '<Plug>(dial-decrement)', opts = opts, mode = 'n'},
        {'<C-a>', '<Plug>(dial-increment)', opts = opts, mode = 'v'},
        {'<C-x>', '<Plug>(dial-decrement)', opts = opts, mode = 'v'},
        {'g<C-a>', '<Plug>(dial-increment-additional)', opts = opts, mode = 'v'},
        {'g<C-x>', '<Plug>(dial-decrement-additional)', opts = opts, mode = 'v'},
    }
end

return M
