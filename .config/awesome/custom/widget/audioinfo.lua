-- Audio info notification
-- custom.widget.audioinfo
-- Parts are from several lain widgets (https://github.com/lcpz/lain)

local helpers           = require("lain.helpers")
local awful             = require("awful")
local naughty           = require("naughty")
local util              = require("custom.util")
local gmatch, match     = string.gmatch, string.match
local pairs             = pairs

local function factory(args)
    local audioinfo = {
        attach_to = args.attach_to or {},
        followtag = args.follow_tag or true,
        notification_preset = args.notification_preset or {
            font = "Monospace 10", fg = "#FFFFFF", bg = "#000000"
        }
    }
    local timeout = args.timeout or 5
    local text = ""

    function audioinfo.update()
        awful.spawn.easy_async_with_shell("LANG=\"en_US.UTF8\" && pacmd list-sinks && pacmd list-sink-inputs", function(stdout)
            local sinks = {}
            local inputs = {}
            local i = 0
            local mode = nil
            -- iterate over the stdout data line by line
            for line in gmatch(stdout, "(.-)[\r\n]+()") do
                -- detect the start of the sink or sink-input section
                if match(line, "sink[(]s[)] available") then mode = "sink"
                elseif match(line, "sink input[(]s[)] available") then mode = "input"
                end
                if mode == "sink" then
                    -- detect the start of a sink
                    local index = match(line, "\\* index: ([%d]+)")
                    if type(index) == "string" then
                        i = tonumber(index) + 1
                        sinks[i] = {}
                        sinks[i].index = index
                        sinks[i].inputs = {}
                    end
                    -- parse sink properties
                    local k, v = match(line, "^[%s]*([%s%w-.]+[%w]+)[%s]*[:=] (.+)")
                    if type(k) == "string" then
                        if     k == "state"              then sinks[i].state = string.lower(v)
                        elseif k == "muted"              then sinks[i].muted = v == "yes"
                        elseif k == "volume"             then sinks[i].volume = match(v, "([%d]+)%%")
                        elseif k == "device.description" then sinks[i].desc = match(v, "\"([^\"]+)\"")
                        elseif k == "device.string"      then sinks[i].string = match(v, "\"([^\"]+)\"")
                        end
                    end
                elseif mode == "input" then
                    -- detect the start of an input
                    local index = match(line, "index: ([%d]+)")
                    if type(index) == "string" then
                        i = tonumber(index) + 1
                        inputs[i] = {}
                        inputs[i].index = index
                    end
                    -- parse input properties
                    local k, v = match(line, "^[%s]*([%s%w-.]+[%w]+)[%s]*[:=] (.+)")
                    if type(k) == "string" then
                        if     k == "sink"               then inputs[i].sink = tonumber(match(v, "([%d]+)[%s]+"))
                        elseif k == "state"              then inputs[i].state = string.lower(v)
                        elseif k == "muted"              then inputs[i].muted = v == "yes"
                        elseif k == "volume"             then inputs[i].volume = match(v, "([%d]+)%%")
                        elseif k == "application.name"   then inputs[i].app = match(v, "\"([^\"]+)\"")
                        elseif k == "media.name"         then inputs[i].media = match(v, "\"([^\"]+)\"")
                        elseif k == "application.process.binary" then inputs[i].bin = match(v, "\"([^\"]+)\"")
                        end
                    end
                end
            end
            -- move inputs to their sink
            for i, input in pairs(inputs) do
                table.insert(sinks[input.sink + 1].inputs, input)
            end
            update_text(sinks)
		end)
    end

    function update_text(sinks)
        text = ""
        local i = 0
        for _, s in ipairs(sinks) do
            if i > 0 then
                text = text .. "\n\n"
            end
            if s.muted then muted = " muted" else muted = "" end
            text = text .. string.format("Sink %s: %s (%s%%%s, %s)", s.index, s.desc, s.volume, muted, s.state)
            for j, t in ipairs(s.inputs) do
                if (t.muted) then tmuted = " muted" else tmuted = "" end
                text = text .. "\n  - " 
                text = text .. string.format("Input %s: %s (%s%%%s, %s)", t.index, t.app or t.media, t.volume, tmuted, t.state)
            end
            if audioinfo.notification then
                naughty.replace_text(audioinfo.notification, nil, text)
            end
            i = i + 1
        end
        if text:len() < 1 then text = "N/A" end
    end
    
    function audioinfo.hide()
        if not audioinfo.notification then return end
        naughty.destroy(audioinfo.notification)
        audioinfo.notification = nil
    end

    function audioinfo.show(seconds, scr)
        audioinfo.update()
        audioinfo.hide()
        audioinfo.notification = naughty.notify {
            text    = text,
            preset  = audioinfo.notification_preset,
            screen  = audioinfo.followtag and awful.screen.focused() or scr or 1,
            icon    = audioinfo.icon,
            timeout = type(seconds) == "number" and seconds or audioinfo.notification_preset.timeout or 5
        }
    end

    function on_hover() 
        audioinfo.show(0) 
    end

    function audioinfo.attach(widget)
        widget:connect_signal("mouse::enter", on_hover)
        widget:connect_signal("mouse::leave", audioinfo.hide)
    end

    for _, widget in pairs(audioinfo.attach_to) do audioinfo.attach(widget) end

    return audioinfo
end

return factory
