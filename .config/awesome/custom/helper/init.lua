local wrequire     = require("lain.helpers").wrequire
local setmetatable = setmetatable

local helper = { _NAME = "custom.helper" }

return setmetatable(helper, { __index = wrequire })
