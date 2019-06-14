local helpers  = require("lain.helpers")
local awful    = require("awful")
local naughty  = require("naughty")
local gmatch   = string.gmatch

local function factory(args)
    local audioinfo = {
        attach_to = args.attach_to or {},
        followtag = args.follow_tag or true,
        notification_preset = args.notification_preset or {
            font = "Monospace 10", fg = "#FFFFFF", bg = "#000000"
        }
    }

    function audioinfo.build_text()
        local data = awful.spawn.easy_async_with_shell("LANG=\"en_US.UTF8\" && pactl list sink-inputs", function(stdout)
            -- split for each input
            local inputs = {}
            local sep = "Sink Input #[%d]+"
            local i = 0
            for line in gmatch(stdout, "(.-)[\r\n]+()") do
                if string.match(line, sep) then
                    i = i + 1
                    inputs[i] = ""
                end
                inputs[i] = inputs[i] .. line .. "\n"
            end

            -- iterate over inputs
            for index, value in pairs(inputs) do
                naughty.notify{text = value}
            end

		end)
        return "test"
    end

    
    function audioinfo.hide()
        if not audioinfo.notification then return end
        naughty.destroy(audioinfo.notification)
        audioinfo.notification = nil
    end

    function audioinfo.show(seconds, scr)
        audioinfo.hide()
        audioinfo.notification = naughty.notify {
            text    = audioinfo.build_text(),
            preset  = audioinfo.notification_preset,
            screen  = audioinfo.followtag and awful.screen.focused() or scr or 1,
            icon    = audioinfo.icon,
            timeout = type(seconds) == "number" and seconds or audioinfo.notification_preset.timeout or 5
        }
    end

    function audioinfo.hover_on() 
        audioinfo.show(0) 
    end
    function audioinfo.move(offset)
        audioinfo.show(0)
    end

    function audioinfo.attach(widget)
        widget:connect_signal("mouse::enter", audioinfo.hover_on)
        widget:connect_signal("mouse::leave", audioinfo.hide)
    end

    for _, widget in pairs(audioinfo.attach_to) do audioinfo.attach(widget) end

    return audioinfo
end

return factory
