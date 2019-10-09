local helpers  = require("lain.helpers")
local json     = require("lain.util").dkjson
local focused  = require("awful.screen").focused
local naughty  = require("naughty")
local wibox    = require("wibox")
local math     = math
local os       = os
local string   = string
local type     = type
local tonumber = tonumber

-- OpenWeatherMap
-- current weather and X-days forecast
-- lain.widget.weather

local function factory(args)
    local weather               = { widget = wibox.widget.textbox() }
    local args                  = args or {}
    local location              = args.location
    local timeout               = args.timeout or 60 * 15 -- 15 min
    local timeout_forecast      = args.timeout or 60 * 60 * 24 -- 24 hrs
    local call                  = "curl 'wttr.in/%s?lang=%s%s'"
    local lang                  = args.lang or "en"
    local notification_preset   = args.notification_preset or {}
    local weather_na_markup     = args.weather_na_markup or " N/A "
    local followtag             = args.followtag or false
    local showpopup             = args.showpopup or "on"
    local settings              = args.settings or function() end

    weather.widget:set_markup(weather_na_markup)

    function weather.show(seconds)
        weather.hide()

        if followtag then
            notification_preset.screen = focused()
        end

        if not weather.notification_text then
            weather.update()
        end

        weather.notification = naughty.notify {
            preset  = notification_preset,
            text    = weather.notification_text,
            timeout = type(seconds == "number") and seconds or notification_preset.timeout
        }
    end

    function weather.hide()
        if weather.notification then
            naughty.destroy(weather.notification)
            weather.notification = nil
        end
    end

    function weather.attach(obj)
        obj:connect_signal("mouse::enter", function()
            weather.show(0)
        end)
        obj:connect_signal("mouse::leave", function()
            weather.hide()
        end)
    end

    function weather.update()
        local cmd = string.format(call, location, lang, "")
        helpers.async(cmd, function(f)
            weather.notification_text = f
        end)
    end

    if showpopup == "on" then weather.attach(weather.widget) end

    weather.timer = helpers.newtimer("weather-" .. location, timeout, weather.update, false, true)

    return weather
end

return factory
