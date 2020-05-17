-- global libraries
local string, os    = string, os
-- libraries
local awful         = require("awful")
                      require("awful.autofocus")
local beautiful     = require("beautiful")


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




-- Layoutlist popup
-- Todo: improve the keybindings, the code from the docs does not work
-- 		 https://awesomewm.org/apidoc/classes/awful.widget.layoutlist.html)
--       gears.table.iterate_value does not exist
-- Todo: Add description and group
local ll = beautiful.layoutlist
local lp = beautiful.layoutpopup
local modkey = "Mod4"
awful.keygrabber {
    start_callback = function() lp.visible = true  end,
    stop_callback  = function() lp.visible = false end,
    export_keybindings = false,
    stop_event = 'press',
    stop_key = {'Escape', 'Return', 'Super_L', 'Super_R', 'Space'},
    mask_modkeys = false,
    root_keybindings = {
        {{ modkey          } , 'space' , function()
        end},
    },
    keybindings = {
        {{					}, 'Right', function()
            awful.layout.inc(1)
        end},
        {{					}, 'Left', function()
            awful.layout.inc(-1)
        end}
    }
}

-- enfoce garbage collection once a minute
gears.timer.start_new(60, function() collectgarbage("collect") return true end)
