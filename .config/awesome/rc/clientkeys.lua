-- libraries
local awful  = require("awful")
local gears  = require("gears")
local lain   = require("lain")
-- settings
local config = require("config")

local lockkey = config.lockkey
local altkey = config.altkey


-- TODO possibility to resize floating clients

clientkeys = gears.table.join(
    awful.key({ lockkey, "Shift" }, "p", lain.util.magnify_client,
        {description = "magnify client", group = "client"}),

    awful.key({ lockkey, "Shift" }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),

    awful.key({ lockkey, "Shift" }, "c", function (c) c:kill() end,
        {description = "close", group = "client"}),

    awful.key({ lockkey, "Shift" }, "g", awful.client.floating.toggle,
        {description = "toggle floating", group = "client"}),

    awful.key({ lockkey, "Shift" }, "t", function (c) c.ontop = not c.ontop end,
        {description = "toggle keep on top", group = "client"}),

    awful.key({ lockkey, "Shift" }, "b", awful.titlebar.toggle,
        {description = "toggle titlebar", group = "client"}),

    awful.key({ lockkey, "Shift" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
        {description = "move to master", group = "client"}),

    awful.key({ lockkey, "Shift" }, "o", function (c) c:move_to_screen() end,
        {description = "move to screen", group = "client"}),

    awful.key({ lockkey, "Shift" }, "n", function (c) c.minimized = true end,
        {description = "minimize", group = "client"}),

    awful.key({ lockkey, "Shift" }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)
