local awful     = require("awful")
local beautiful = require("beautiful")

local volume = {}

local function update()
    beautiful.volume.update()
end

local function call(cmd)
    awful.spawn.easy_async_with_shell(cmd, function()
        update()
    end)
end

volume.increase = function(by)
    call(string.format("pactl set-sink-volume %d +%d%%", beautiful.volume.device, by))
end

volume.decrease = function(by)
    call(string.format("pactl set-sink-volume %d -%d%%", beautiful.volume.device, by))
end

volume.toggle_mute = function()
    call(string.format("pactl set-sink-mute %d toggle", beautiful.volume.device))
end

return volume
