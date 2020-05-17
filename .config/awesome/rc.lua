-- global libraries
local string, os    = string, os
-- libraries
local awful         = require("awful")
                      require("awful.autofocus")
local beautiful     = require("beautiful")
local gears         = require("gears")


awful.key.ignore_modifiers = { "Mod2" }

-- startup
require("rc.errorhandling")
require("rc.autostart")

awful.util.terminal = require("apps").terminal.cmd

require("rc.tags")
require("rc.tasks")
require("rc.layouts")

-- load theme
local theme = "one"
beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), theme))

-- misc
require("rc.screenshots")       -- screenshot helper setup

-- clients
require("rc.clientkeys")        -- key bindings
require("rc.rules")             -- client creation rules
require("rc.clientbuttons")     -- window decoration buttons
require("rc.client_signals")    -- event handling

-- misc
require("rc.globalkeys")        -- global key bindings

-- screens
require("rc.screen_signals")    -- event handling

-- enfoce garbage collection once a minute
gears.timer.start_new(60, function() collectgarbage("collect") return true end)
