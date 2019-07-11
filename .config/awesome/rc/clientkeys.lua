-- libraries
local awful  = require("awful")
local gears  = require("gears")
local lain   = require("lain")
-- settings
local config = require("config")

local altgrkey = config.altgrkey
local altkey = config.altkey


-- TODO possibility to resize floating clients

clientkeys = gears.table.join(
    awful.key({ altgrkey, "Shift" }, "p", lain.util.magnify_client,
        {description = "magnify client", group = "client"}),

    awful.key({ altgrkey, "Shift" }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),

    awful.key({ altgrkey, "Shift" }, "c", function (c) c:kill() end,
        {description = "close", group = "client"}),

    awful.key({ altgrkey, "Shift" }, "g", awful.client.floating.toggle,
        {description = "toggle floating", group = "client"}),

    awful.key({ altgrkey, "Shift" }, "t", function (c) c.ontop = not c.ontop end,
        {description = "toggle keep on top", group = "client"}),

    awful.key({ altgrkey, "Shift" }, "b", awful.titlebar.toggle,
        {description = "toggle titlebar", group = "client"}),

    awful.key({ altgrkey, "Shift" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
        {description = "move to master", group = "client"}),

    awful.key({ altgrkey, "Shift" }, "o", function (c) c:move_to_screen() end,
        {description = "move to screen", group = "client"}),

    awful.key({ altgrkey, "Shift" }, "n", function (c) c.minimized = true end,
        {description = "minimize", group = "client"}),

    awful.key({ altgrkey, "Shift" }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)
