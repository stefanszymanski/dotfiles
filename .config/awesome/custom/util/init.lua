local wrequire     = require("lain.helpers").wrequire
local setmetatable = setmetatable

local util = { _NAME = "custom.util" }

return setmetatable(util, { __index = wrequire })
