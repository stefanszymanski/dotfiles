-- globals
local clientkeys    = clientkeys
local clientbuttons = clientbuttons
-- libraries
local awful     = require("awful")
local beautiful = require("beautiful")


-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
     -- All clients will match this rule
    {
        rule = { },
        properties = {
            border_width      = beautiful.border_width,
            border_color      = beautiful.border_normal,
            focus             = awful.client.focus.filter,
            raise             = true,
            keys              = clientkeys,
            buttons           = clientbuttons,
            screen            = awful.screen.preferred,
            placement         = awful.placement.no_offscreen
                              + awful.placement.no_overlap,
            delayed_placement = awful.placement.centered,
            size_hints_honor  = false,
            titlebars_enabled = true,
        },
    },
    {
        rule = { instance = "nagstamon" },
        properties = {
            focusable = false
        }
    }
}
