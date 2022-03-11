local M = {}

M.config = function()
    local dapvt = require('nvim-dap-virtual-text')

    dapvt.setup {
        commented = true,
        all_frames = true,
    }

    vim.cmd [[ hi link NvimDapVirtualText DiagnosticVirtualTextHint ]]
end

return M
