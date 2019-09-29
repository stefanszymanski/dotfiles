-- globals
local awesome = awesome
-- libraries
local awful         = require("awful")
local beautiful     = require("beautiful")
-- local freedesktop   = require("freedesktop")
local dpi           = require("beautiful.xresources").apply_dpi
-- widgets
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      require("awful.hotkeys_popup.keys")
-- settings
local apps          = require("apps")


local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", apps.terminal.open_cmd("man awesome") },
    { "edit config", apps.editor.open_cmd(awesome.conffile) },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end }
}

-- awful.util.mymainmenu = freedesktop.menu.build({
--     icon_size = beautiful.menu_height or dpi(16),
--     before = {
--         { "Awesome", myawesomemenu, beautiful.awesome_icon },
--         -- other triads can be put here
--     },
--     after = {
--         { "Open terminal", apps.terminal.cmd },
--         -- other triads can be put here
--     }
-- })

-- hide menu when mouse leaves it
-- awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function() awful.util.mymainmenu:hide() end)
