local M = {
    'monaqa/dial.nvim',
    keys = {
        {'<C-a>', '<Plug>(dial-increment)', mode = {'n', 'v'}},
        {'<C-x>', '<Plug>(dial-decrement)', mode = {'n', 'v'}},
    },
}

M.config = function()
    local augend = require('dial.augend')
    local dial = require('dial.config')

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
            augend.date.alias["%d.%m.%Y"],
            augend.semver.alias.semver,
            augend.constant.new {
                elements = {'private', 'protected', 'public'},
                word = true,
                cyclic = true,
            },
            augend.constant.new {
                elements = {'True', 'False'},
                word = true,
                cyclic = true,
            },
            augend.constant.new {
                elements = {'&&', '||'},
                word = false,
                cyclic = true,
            },
            augend.constant.new {
                elements = {'first', 'second', 'third', 'fourth', 'fifth', 'sixth', 'seventh', 'eigth', 'nineth', 'tenth', 'eleventh', 'twelfth'},
                word = true,
                cyclic = false,
            },
            augend.constant.new {
                elements = {'[ ]', '[x]', '[-]'},
                word = false,
                cyclic = true,
            },
        }
    }
end

return M
