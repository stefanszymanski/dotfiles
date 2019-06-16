-- libraries
local awful         = require("awful")
local beautiful     = require("beautiful")
local gears         = require("gears")
local lain          = require("lain")
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      require("awful.hotkeys_popup.keys")
-- helper scripts
local screenshot    = require("custom.helper.screenshot")
local volume        = require("custom.helper.volume")
-- settings
local apps          = require("apps")

local modkey       = "Mod4"
local altkey       = "Mod1"

globalkeys = gears.table.join(
    -- Take a screenshot
    awful.key({         }, "Print", screenshot.screen,
        {description = "take a screenshot of the full screen", group = "screenshots"}),
    awful.key({ "Shift" }, "Print", screenshot.focused,
        {description = "take a screenshot of the focused window", group = "screenshots"}),
    awful.key({ "Control" }, "Print", screenshot.selection,
        {description = "take a screenshot of a selected area", group = "screenshots"}),

    -- screen locker
    awful.key({ modkey            }, "F12", function () os.execute(apps.screenlocker) end,
        {description = "lock screen", group = "hotkeys"}),

    -- Hotkeys
    awful.key({ modkey,           }, "s", hotkeys_popup.show_help,
        {description = "show help", group="awesome"}),

    -- Tag browsing
    awful.key({ modkey,           }, "Left", awful.tag.viewprev,
        {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right", awful.tag.viewnext,
        {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
        {description = "go back", group = "tag"}),
    -- Non-empty tag browsing
    awful.key({ altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end,
        {description = "view  previous nonempty", group = "tag"}),
    awful.key({ altkey }, "Right", function () lain.util.tag_view_nonempty(1) end,
        {description = "view  previous nonempty", group = "tag"}),

    -- Default client focus
    awful.key({ altkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}),
    awful.key({ altkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}),
    -- By direction client focus
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "client"}),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "client"}),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "client"}),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "client"}),
    awful.key({ modkey,           }, "w", function () awful.util.mymainmenu:show() end,
        {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
        {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
        {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
        {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
        {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
        {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Show/Hide Wibox
    awful.key({ modkey }, "b", 
        function ()
            for s in screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end,
        {description = "toggle wibox", group = "awesome"}),

    -- On the fly useless gaps change
    awful.key({ altkey, "Control" }, "+", function () lain.util.useless_gaps_resize(1) end,
        {description = "increment useless gaps", group = "tag"}),
    awful.key({ altkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-1) end,
        {description = "decrement useless gaps", group = "tag"}),

    -- Dynamic tagging
    awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end,
        {description = "add new tag", group = "tag"}),
    awful.key({ modkey, "Shift" }, "r", function () lain.util.rename_tag() end,
        {description = "rename tag", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
        {description = "move tag to the left", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
        {description = "move tag to the right", group = "tag"}),
    awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end,
        {description = "delete tag", group = "tag"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(apps.terminal) end,
        {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "Return", function () awful.spawn(apps.terminal .. " -e bash -c \"tmux\"") end,
        {description = "open a terminal with tmux", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
        {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
        {description = "quit awesome", group = "awesome"}),

    awful.key({ altkey, "Shift"   }, "l",     function () awful.tag.incmwfact( 0.05)          end,
        {description = "increase master width factor", group = "layout"}),
    awful.key({ altkey, "Shift"   }, "h",     function () awful.tag.incmwfact(-0.05)          end,
        {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
        {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
        {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
        {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
        {description = "decrease the number of columns", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
                c:raise()
            end
        end,
        {description = "restore minimized", group = "client"}),

    -- Widgets popups
    awful.key({ altkey, }, "c", function () if beautiful.cal then beautiful.cal.show(7) end end,
        {description = "show calendar", group = "widgets"}),
    awful.key({ altkey, }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end,
        {description = "show filesystem", group = "widgets"}),
    awful.key({ altkey, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end,
        {description = "show weather", group = "widgets"}),

    -- Brightness
    awful.key({ }, "XF86MonBrightnessUp", function () os.execute("xbacklight -inc 10") end),
    awful.key({ }, "XF86MonBrightnessDown", function () os.execute("xbacklight -dec 10") end),

    -- ALSA volume control
    awful.key({ altkey }, "Up", function () volume.increase(5) end,
        {description = "volume up", group = "audio"}),
    awful.key({ altkey }, "Down", function () volume.decrease(5) end,
        {description = "volume down", group = "audio"}),
    awful.key({ altkey }, "m", volume.toggle_mute,
        {description = "toggle mute", group = "audio"}),
    awful.key({ }, "XF86AudioRaiseVolume", function () volume.increase(5) end),
    awful.key({ }, "XF86AudioLowerVolume", function () volume.increase(5) end),
    awful.key({ }, "XF86AudioMute", volume.toggle_mute),

    -- Copy primary to clipboard (terminals to gtk)
    awful.key({ modkey }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end,
        {description = "copy terminal to gtk", group = "hotkeys"}),
    -- Copy clipboard to primary (gtk to terminals)
    awful.key({ modkey }, "v", function () awful.spawn.with_shell("xsel -b | xsel") end,
        {description = "copy gtk to terminal", group = "hotkeys"}),

    -- User programs
    awful.key({ modkey }, "q", function () awful.spawn(apps.browser) end,
        {description = "run browser", group = "launcher"}),

    -- Prompts
    awful.key({ modkey }, "r", function () beautiful.prompt.run() end,
        {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x", function () beautiful.luaprompt.run() end,
        {description = "lua execute prompt", group = "awesome"})
)

clientkeys = gears.table.join(
    awful.key({ altkey, "Shift"   }, "m",      lain.util.magnify_client,
        {description = "magnify client", group = "client"}),
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
        {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
        {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
        {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
        {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
        {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)
