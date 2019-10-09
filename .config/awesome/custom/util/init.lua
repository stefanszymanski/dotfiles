local wrequire     = require("lain.helpers").wrequire
local setmetatable = setmetatable

local util = { _NAME = "custom.util" }
local tag = { _NAME = "custom.tag" }

return setmetatable(util, { __index = wrequire })
