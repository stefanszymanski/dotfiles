local awful = require("awful")

function clientactions(c)
    local on = " <span size='large'>✓</span>"
    local off = ""

    local entries = "1: maximize"   .. (c.maximized  and on or off) .. "\n"
                 .. "2: fullscreen" .. (c.fullscreen and on or off) .. "\n"
                 .. "3: sticky"     .. (c.sticky     and on or off) .. "\n"
                 .. "4: ontop"      .. (c.ontop      and on or off) .. "\n"
                 .. "5: floating"   .. (c.floating   and on or off) .. "\n"
                 .. "6: minimize\n"
                 .. "7: kill"

    local width = math.min(c.width, 10)
    local x = c.x - c.screen.geometry.x
    local y = c.y - c.screen.geometry.y

    local cmd = "echo -e \"" .. entries .. "\" | "
             .. " rofi -dmenu -i"
             .. " -markup-rows"
             .. " -lines 7"
             .. " -p 'client action'"
             .. " -xoffset " .. x
             .. " -yoffset " .. y
             .. " -width " .. width
             .. " -location 1"
             .. " | cut -d ':' -f 1"

    awful.spawn.easy_async({"bash", "-c", cmd}, function(out)
        for k in string.gmatch(out, "([0-9])") do
            if k == "1" then
                c.maximized = not c.maximized
                c:raise()
            elseif k == "2" then
                c.fullscreen = not c.fullscreen
                c:raise()
            elseif k == "3" then
                c.sticky = not c.sticky
            elseif k == "4" then
                c.ontop = not c.ontop
            elseif k == "5" then
                c.floating = not c.floating
            elseif k == "6" then
                c.minimized = true
            elseif k == "7" then
                c:kill()
            end
        end
    end)
end

return clientactions
