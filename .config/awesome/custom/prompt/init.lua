local wrequire     = require("lain.helpers").wrequire
local setmetatable = setmetatable

local prompt = { _NAME = "custom.prompt" }

return setmetatable(prompt, { __index = wrequire })
