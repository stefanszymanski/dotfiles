local wrequire     = require("lain.helpers").wrequire
local setmetatable = setmetatable

local widget = { _NAME = "custom.widget" }

return setmetatable(widget, { __index = wrequire })