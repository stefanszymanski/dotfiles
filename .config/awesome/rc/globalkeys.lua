-- libraries
local awful         = require("awful")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local gears         = require("gears")
local lain          = require("lain")
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      require("awful.hotkeys_popup.keys")
-- helper scripts
local screenshot    = require("custom.helper.screenshot")
local volume        = require("custom.helper.volume")
-- settings
local apps          = require("apps")
local config        = require("config")

local modkey        = config.modkey
local altkey        = config.altkey
local lockkey       = config.lockkey


globalkeys = gears.table.join(
    -- Take a screenshot
    awful.key({ }, "Print", screenshot.screen,
        {description = "take a screenshot of the full screen", group = "screenshots"}),
    awful.key({ "Shift" }, "Print", screenshot.focused,
        {description = "take a screenshot of the focused window", group = "screenshots"}),
    awful.key({ "Control" }, "Print", screenshot.selection,
        {description = "take a screenshot of a selected area", group = "screenshots"}),

    -- screen locker
    awful.key({ modkey }, "F12", apps.screenlocker.run,
        {description = "lock screen", group = "hotkeys"}),

    -- Hotkeys
    awful.key({ modkey }, "s", hotkeys_popup.show_help,
        {description = "show help", group="awesome"}),

    -- Tag browsing
    awful.key({ modkey }, "k", awful.tag.viewprev,
        {description = "view previous", group = "tag"}),
    awful.key({ modkey }, "j", awful.tag.viewnext,
        {description = "view next", group = "tag"}),
    -- awful.key({ modkey }, "Left", awful.tag.viewprev,
    --     {description = "view previous", group = "tag"}),
    -- awful.key({ modkey }, "Right", awful.tag.viewnext,
    --     {description = "view next", group = "tag"}),
    awful.key({ modkey }, "Escape", awful.tag.history.restore,
        {description = "go back", group = "tag"}),
    -- Non-empty tag browsing
    awful.key({ modkey, "Shift" }, "j", function () lain.util.tag_view_nonempty(-1) end,
        {description = "view previous nonempty", group = "tag"}),
    awful.key({ modkey, "Shift" }, "k", function () lain.util.tag_view_nonempty(1) end,
        {description = "view next nonempty", group = "tag"}),
    -- awful.key({ modkey, "Shift" }, "Left", function () lain.util.tag_view_nonempty(-1) end,
    --     {description = "view previous nonempty", group = "tag"}),
    -- awful.key({ modkey, "Shift" }, "Right", function () lain.util.tag_view_nonempty(1) end,
    --     {description = "view next nonempty", group = "tag"}),

    -- Default client focus
    awful.key({ lockkey, altkey }, "k", function () awful.client.focus.byidx( 1) end,
        {description = "focus next by index", group = "client navigation"}),
    awful.key({ lockkey, altkey }, "j", function () awful.client.focus.byidx(-1) end,
        {description = "focus previous by index", group = "client navigation"}),
    -- awful.key({ lockkey, altkey }, "Left", function () awful.client.focus.byidx( 1) end,
        -- {description = "focus next by index", group = "client navigation"}),
    -- awful.key({ lockkey, altkey }, "Right", function () awful.client.focus.byidx(-1) end,
        -- {description = "focus previous by index", group = "client navigation"}),
    -- By direction client focus
    awful.key({ lockkey }, "j",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "client navigation"}),
    awful.key({ lockkey }, "k",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "client navigation"}),
    awful.key({ lockkey }, "h",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "client navigation"}),
    awful.key({ lockkey }, "l",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "client navigation"}),
    -- awful.key({ lockkey }, "Down",
    --     function()
    --         awful.client.focus.global_bydirection("down")
    --         if client.focus then client.focus:raise() end
    --     end,
    --     {description = "focus down", group = "client navigation"}),
    -- awful.key({ lockkey }, "Up",
    --     function()
    --         awful.client.focus.global_bydirection("up")
    --         if client.focus then client.focus:raise() end
    --     end,
    --     {description = "focus up", group = "client navigation"}),
    -- awful.key({ lockkey }, "Left",
    --     function()
    --         awful.client.focus.global_bydirection("left")
    --         if client.focus then client.focus:raise() end
    --     end,
    --     {description = "focus left", group = "client navigation"}),
    -- awful.key({ lockkey }, "Right",
    --     function()
    --         awful.client.focus.global_bydirection("right")
    --         if client.focus then client.focus:raise() end
    --     end,
    --     {description = "focus right", group = "client navigation"}),
    -- awful.key({ modkey }, "w", function () awful.util.mymainmenu:show() end,
    --     {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ lockkey, altkey }, "h", function () awful.client.swap.byidx(  1)    end,
        {description = "swap with next by index", group = "client navigation"}),
    awful.key({ lockkey, altkey }, "l", function () awful.client.swap.byidx( -1)    end,
        {description = "swap with previous by index", group = "client navigation"}),
    awful.key({ modkey }, "h", function () awful.screen.focus_relative( 1) end,
        {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey }, "l", function () awful.screen.focus_relative(-1) end,
        {description = "focus the previous screen", group = "screen"}),
    awful.key({ lockkey }, "u", awful.client.urgent.jumpto,
        {description = "jump to urgent client", group = "client navigation"}),
    awful.key({ lockkey }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client navigation"}),

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
--    awful.key({ altkey, "Control" }, "+", function () lain.util.useless_gaps_resize(1) end,
--        {description = "increment useless gaps", group = "tag"}),
--    awful.key({ altkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-1) end,
--        {description = "decrement useless gaps", group = "tag"}),

    -- Dynamic tagging
    awful.key({ lockkey, "Control" }, "n", function () lain.util.add_tag() end,
        {description = "add new tag", group = "tag"}),
    awful.key({ lockkey, "Control" }, "r", function () lain.util.rename_tag() end,
        {description = "rename tag", group = "tag"}),
    awful.key({ lockkey, "Control" }, "h", function () lain.util.move_tag(-1) end,
        {description = "move tag to the left", group = "tag"}),
    awful.key({ lockkey, "Control" }, "l", function () lain.util.move_tag(1) end,
        {description = "move tag to the right", group = "tag"}),
    -- awful.key({ lockkey, "Control" }, "Left", function () lain.util.move_tag(-1) end,
    --     {description = "move tag to the left", group = "tag"}),
    -- awful.key({ lockkey, "Control" }, "Right", function () lain.util.move_tag(1) end,
    --     {description = "move tag to the right", group = "tag"}),
    awful.key({ lockkey, "Control" }, "d", function () lain.util.delete_tag() end,
        {description = "delete tag", group = "tag"}),

    -- Standard program
    awful.key({ modkey }, "Return", function () awful.spawn(apps.terminal.cmd) end,
        {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "Return", function () awful.spawn(apps.terminal.cmd .. " -e tmux") end,
        {description = "open a terminal with tmux", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
        {description = "reload awesome", group = "awesome"}),
    --awful.key({ modkey, "Shift"   }, "q", awesome.quit,
    --    {description = "quit awesome", group = "awesome"}),

    awful.key({ lockkey, "Shift" }, "l",     function () awful.tag.incmwfact( 0.05)          end,
        {description = "increase master width factor", group = "layout"}),
    awful.key({ lockkey, "Shift" }, "h",     function () awful.tag.incmwfact(-0.05)          end,
        {description = "decrease master width factor", group = "layout"}),
    --awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
    --    {description = "increase the number of master clients", group = "layout"}),
    --awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
    --    {description = "decrease the number of master clients", group = "layout"}),
    --awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
    --    {description = "increase the number of columns", group = "layout"}),
    --awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
    --    {description = "decrease the number of columns", group = "layout"}),

    awful.key({ lockkey }, "n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
                c:raise()
            end
        end,
        {description = "restore minimized", group = "tag"}),

    -- Widgets popups
    awful.key({ lockkey }, "c", function () if beautiful.cal then beautiful.cal.show(7) end end,
        {description = "show calendar", group = "widgets"}),
    awful.key({ lockkey }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end,
        {description = "show filesystem", group = "widgets"}),
    awful.key({ lockkey }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end,
        {description = "show weather", group = "widgets"}),
    
    -- Notifictations
    awful.key({ lockkey }, "x", naughty.destroy_all_notifications,
        {description = "close nofitications", group = "hotkeys"}),

    -- Brightness
    awful.key({ }, "XF86MonBrightnessUp", function () os.execute("xbacklight -inc 10") end),
    awful.key({ }, "XF86MonBrightnessDown", function () os.execute("xbacklight -dec 10") end),

    -- ALSA volume control
    awful.key({ lockkey }, "+", function () volume.increase(5) end,
        {description = "volume up", group = "audio"}),
    awful.key({ lockkey }, "-", function () volume.decrease(5) end,
        {description = "volume down", group = "audio"}),
    awful.key({ lockkey }, "m", volume.toggle_mute,
        {description = "toggle mute", group = "audio"}),
    awful.key({ }, "XF86AudioRaiseVolume", function () volume.increase(5) end),
    awful.key({ }, "XF86AudioLowerVolume", function () volume.decrease(5) end),
    awful.key({ }, "XF86AudioMute", volume.toggle_mute),

    -- Copy primary to clipboard (terminals to gtk)
    awful.key({ modkey }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end,
        {description = "copy primary to clipboard", group = "hotkeys"}),
    -- Copy clipboard to primary (gtk to terminals)
    awful.key({ modkey }, "v", function () awful.spawn.with_shell("xsel -b | xsel") end,
        {description = "copy clipboard to primary", group = "hotkeys"}),

    -- User programs
    awful.key({ modkey }, "q", function () awful.spawn(apps.browser.cmd) end,
        {description = "run browser", group = "launcher"}),

    -- Prompts
    awful.key({ modkey }, "r", function () beautiful.prompt.run() end,
        {description = "run prompt", group = "launcher"}),

--    awful.key({ modkey }, "x", function () beautiful.luaprompt.run() end,
--        {description = "run lua execute prompt", group = "awesome"}),

    awful.key({ modkey }, ",", function () awful.spawn.with_shell("rofi -show run") end,
        {description = "show command launcher", group = "launcher"}),
    awful.key({ modkey }, ".", function () awful.spawn.with_shell("rofi -show drun") end,
        {description = "show application launcher", group = "launcher"}),
    awful.key({ modkey }, "-", function () awful.spawn.with_shell("rofi -show ssh") end,
        {description = "show ssh launcher", group = "launcher"}),
    awful.key({ modkey }, "#", function () awful.spawn.with_shell("rofi -show window") end,
        {description = "show window switcher", group = "launcher"}),
    awful.key({ modkey }, "+", function () awful.spawn.with_shell("$HOME/.bin/sessionmenu") end,
        {description = "show session menu", group = "launcher"})

)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = "tag"}
        descr_toggle = {description = "toggle tag #", group = "tag"}
        descr_move = {description = "move to tag #", group = "client"}
        descr_toggle_focus = {description = "toggle on tag #", group = "client"}
    end
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
        descr_view),
        -- Toggle tag display.
        awful.key({ modkey, altkey }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
        descr_toggle),
        -- Move client to tag.
        awful.key({ lockkey }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
        descr_move),
        -- Toggle tag on focused client.
        awful.key({ lockkey, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
        descr_toggle_focus)
    )
end

root.keys(globalkeys)
