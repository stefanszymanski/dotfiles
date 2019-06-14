-- Lua prompt in popup

local promptbox = require("custom.prompt.promptbox")
local awful     = require("awful")
local naughty   = require("naughty")
local gears     = require("gears")

local function factory(args)

    function default_args()
        return {
            prompt = "Run Lua code: ",
            history_path = awful.util.get_cache_dir() .. "/history_eval",
            exe_callback = function(input)
                local status, result = pcall(awful.util.eval, input)
                if type(result) == "string" then
                    if (status) then
                        naughty.notify { title = "Lua prompt", text = result }
                    else
                        naughty.notify { title = "Lua prompt error", text = result, preset = naughty.config.presets.critical }
                    end
                end

            end,
        }
    end

    args = gears.table.join(default_args(), args or {})

    local luapromptbox = promptbox(args)
    return luapromptbox
end

return factory
