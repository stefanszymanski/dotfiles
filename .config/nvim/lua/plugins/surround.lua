local M = {
    -- Create, change, delete surroundings
    'tpope/vim-surround',
    keys = {
        {'ys', desc = 'Surround {motion} with {char}'},
        {'yS', desc = 'Surround {motion} with {char} and wrap'},
        {'yss', desc = 'Surround line with {char}'},
        {'ySs', desc = 'Surround line with {char} and wrap'},
        {'cs', desc = 'Change surrounding {char} to {char}'},
        {'cS', desc = 'Change surrounding {char} to {char} and wrap'},
        {'ds', desc = 'Delete surrounding {char}'},
        {'gS', desc = 'Surround with {char} and wrap', mode = 'v'},
    }
}

return M
