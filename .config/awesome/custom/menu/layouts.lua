local awful     = require("awful")
local beautiful = require("beautiful")

function layouts()
    local active_screen = awful.screen.focused()
    local active_layout = awful.layout.get(active_screen)
    local active_layout_index = 0

    local entries = ""
    for i, layout in pairs(awful.layout.layouts) do
        local name = awful.layout.getname(layout)
        entries = entries .. i .. ": " .. name .. "\n"
        if layout == active_layout then
            active_layout_index = i - 1
        end
    end

    local lines = #awful.layout.layouts
    local width = 10

    local cmd = "echo -en \"" .. entries .. "\" | "
             .. " rofi -dmenu -i"
             .. " -lines " .. lines
             .. " -p 'layout'"
             .. " -width " .. width
             .. " -selected-row " .. active_layout_index
             .. " | cut -d ':' -f 1"

    awful.spawn.easy_async({"bash", "-c", cmd}, function(out)
        local i = tonumber(out) or 0
        if i == 0 then
            return
        end
        local selected_layout = awful.layout.layouts[i]
        awful.layout.set(selected_layout)
    end)
end

return layouts
