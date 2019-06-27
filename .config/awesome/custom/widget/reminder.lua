local naughty = require("naughty")
local gears   = require("gears")

local function factory(args)
    args = args or {}

    local reminder = {
        notification = nil,
        timer        = nil,
        title        = args.title or nil,
        text         = args.text or nil,
        preset       = args.preset or nil,
        interval     = args.interval or 3600,
    }

    function reminder.show()
        if not reminder.notification then
            reminder.notification = naughty.notify {
                title = reminder.title,
                text = reminder.text,
                preset = reminder.preset,
                destroy = reminder.reset,
            }
        end
    end

    function reminder.reset()
        reminder.notification = nil 
        reminder.timer:again()
    end

    reminder.timer = gears.timer {
        timeout = reminder.interval,
        callback = reminder.show,
        autostart = true,
    }

    return reminder
end

return factory
