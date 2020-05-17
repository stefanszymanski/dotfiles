local wrequire     = require("lain.helpers").wrequire
local setmetatable = setmetatable

local menu = { _NAME = "custom.menu" }

return setmetatable(menu, { __index = wrequire })
