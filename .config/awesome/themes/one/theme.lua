--[[
     Custom Layout One (WIP)

     Heavily copied from
     - Colors, Sizes: https://github.com/alfunx/.dotfiles/blob/master/.config/awesome/themes/blackout/theme.lua
     - Widgets: https://github.com/lcpz/awesome-copycats

     Future features
     - popups for widgets (memory, cpu, network, volume)
     - Layout list
--]]


local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local awesome, client, os = awesome, client, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
local markup = lain.util.markup


local colors                                    = { }

colors.black_1                                  = "#282828"
colors.black_2                                  = "#928374"
colors.red_1                                    = "#cc241d"
colors.red_2                                    = "#fb4934"
colors.green_1                                  = "#98971a"
colors.green_2                                  = "#b8bb26"
colors.yellow_1                                 = "#d79921"
colors.yellow_2                                 = "#fabd2f"
colors.blue_1                                   = "#458588"
colors.blue_2                                   = "#83a598"
colors.purple_1                                 = "#b16286"
colors.purple_2                                 = "#d3869b"
colors.aqua_1                                   = "#689d6a"
colors.aqua_2                                   = "#8ec07c"
colors.white_1                                  = "#a89984"
colors.white_2                                  = "#ebdbb2"
colors.orange_1                                 = "#d65d0e"
colors.orange_2                                 = "#fe8019"

colors.bw_0_h                                   = "#1d2021"
colors.bw_0                                     = "#282828"
colors.bw_0_s                                   = "#32302f"
colors.bw_1                                     = "#3c3836"
colors.bw_2                                     = "#504945"
colors.bw_3                                     = "#665c54"
colors.bw_4                                     = "#7c6f64"
colors.bw_5                                     = "#928374"
colors.bw_6                                     = "#a89984"
colors.bw_7                                     = "#bdae93"
colors.bw_8                                     = "#d5c4a1"
colors.bw_9                                     = "#ebdbb2"
colors.bw_10                                    = "#fbf1c7"


local theme                                     = {}

theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/one"
theme.wallpaper                                 = theme.dir .. "/wall.png"

local font_name                                 = "Inconsolata for Powerline"
local font_size                                 = "12"
theme.font                                      = font_name .. " " ..                         font_size
theme.font_bold                                 = font_name .. " " .. "Bold"        .. " " .. font_size
theme.font_italic                               = font_name .. " " .. "Italic"      .. " " .. font_size
theme.font_bold_italic                          = font_name .. " " .. "Bold Italic" .. " " .. font_size
theme.font_big                                  = font_name .. " " .. "Bold" .. " 16"

theme.accent                                    = colors.red_2
theme.border_normal                             = colors.bw_2
theme.border_focus                              = colors.bw_5
theme.border_marked                             = colors.bw_5

theme.titlebar_fg_normal                        = colors.bw_5
theme.titlebar_fg_focus                         = colors.bw_8
theme.titlebar_fg_marked                        = colors.bw_8
theme.titlebar_fg_urgent                        = colors.red_2
theme.titlebar_bg_normal                        = colors.bw_2
theme.titlebar_bg_focus                         = colors.bw_5
theme.titlebar_bg_marked                        = colors.bw_5
theme.titlebar_bg_marked                        = colors.bw_5

theme.fg_normal                                 = colors.bw_9
theme.fg_focus                                  = colors.bw_9
theme.fg_urgent                                 = colors.red_2
theme.bg_normal                                 = colors.bw_0
theme.bg_focus                                  = colors.bw_2
theme.bg_urgent                                 = colors.bw_2

theme.taglist_font                              = theme.font_bold
theme.taglist_fg_normal                         = colors.bw_5
theme.taglist_fg_occupied                       = colors.bw_5
theme.taglist_fg_empty                          = colors.bw_1
theme.taglist_fg_volatile                       = colors.aqua_2
theme.taglist_fg_focus                          = colors.bw_9
theme.taglist_fg_urgent                         = colors.red_2
theme.taglist_bg_normal                         = colors.bw_0
theme.taglist_bg_occupied                       = colors.bw_0
theme.taglist_bg_empty                          = colors.bw_0
theme.taglist_bg_volatile                       = colors.bw_0
theme.taglist_bg_focus                          = colors.bw_0
theme.taglist_bg_urgent                         = colors.bw_1

theme.tasklist_font_normal                      = theme.font
theme.tasklist_font_focus                       = theme.font_bold
theme.tasklist_font_minimized                   = theme.font
theme.tasklist_font_urgent                      = theme.font_bold

theme.tasklist_fg_normal                        = colors.bw_5
theme.tasklist_fg_focus                         = colors.bw_8
theme.tasklist_fg_minimize                      = colors.bw_2
theme.tasklist_fg_urgent                        = colors.red_2
theme.tasklist_bg_normal                        = colors.bw_0
theme.tasklist_bg_focus                         = colors.bw_0
theme.tasklist_bg_minimize                      = colors.bw_0
theme.tasklist_bg_urgent                        = colors.bw_0

theme.tasklist_shape_border_color               = colors.purple_2
theme.tasklist_shape_border_color_focus         = colors.green_2
theme.tasklist_shape_border_color_minimized     = colors.blue_2
theme.tasklist_shape_border_color_urgent        = colors.red_2

theme.hotkeys_border_width                      = theme.border
theme.hotkeys_border_color                      = colors.bw_5
theme.hotkeys_group_margin                      = 50

theme.prompt_bg                                 = colors.bw_0
theme.prompt_fg                                 = theme.fg_normal
theme.bg_systray                                = colors.bw_0

theme.border                                    = 2
theme.border_width                              = 2
theme.border_radius                             = 0
theme.fullscreen_hide_border                    = true
theme.maximized_hide_border                     = true
theme.menu_height                               = 20
theme.menu_width                                = 250
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.tasklist_spacing                          = 3
theme.useless_gap                               = 6
theme.systray_icon_spacing                      = 4

theme.bar_bg                                    = colors.bw_0
theme.bar_fg                                    = colors.bw_5
theme.bar_height                                = 20

theme.layout_cascadetile                        = theme.dir .. "/icons/layouts/cascadetile.png"
theme.layout_centerwork                         = theme.dir .. "/icons/layouts/centerwork.png"
theme.layout_cornerne                           = theme.dir .. "/icons/layouts/cornerne.png"
theme.layout_cornernw                           = theme.dir .. "/icons/layouts/cornernw.png"
theme.layout_cornerse                           = theme.dir .. "/icons/layouts/cornerse.png"
theme.layout_cornersw                           = theme.dir .. "/icons/layouts/cornersw.png"
theme.layout_dwindle                            = theme.dir .. "/icons/layouts/dwindle.png"
theme.layout_fairh                              = theme.dir .. "/icons/layouts/fairh.png"
theme.layout_fairv                              = theme.dir .. "/icons/layouts/fairv.png"
theme.layout_floating                           = theme.dir .. "/icons/layouts/floating.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/layouts/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/layouts/magnifier.png"
theme.layout_max                                = theme.dir .. "/icons/layouts/max.png"
theme.layout_spiral                             = theme.dir .. "/icons/layouts/spiral.png"
theme.layout_tile                               = theme.dir .. "/icons/layouts/tile.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/layouts/tilebottom.png"
theme.layout_tileleft                           = theme.dir .. "/icons/layouts/tileleft.png"
theme.layout_tiletop                            = theme.dir .. "/icons/layouts/tiletop.png"
theme.layout_treetile                           = theme.dir .. "/icons/layouts/treetile.png"

theme.awesome_icon                              = theme.dir .. "/icons/awesome.png"
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
--theme.taglist_squares_sel                       = theme.dir .. "/icons/square_unsel.png"
--theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.vol                                       = theme.dir .. "/icons/info/vol.png"
theme.vol_low                                   = theme.dir .. "/icons/info/vol_low.png"
theme.vol_no                                    = theme.dir .. "/icons/info/vol_no.png"
theme.vol_mute                                  = theme.dir .. "/icons/info/vol_mute.png"
theme.disk                                      = theme.dir .. "/icons/info/disk.png"
theme.ac                                        = theme.dir .. "/icons/info/ac.png"
theme.bat                                       = theme.dir .. "/icons/info/battery.png"
theme.bat_low                                   = theme.dir .. "/icons/info/battery_low.png"
theme.bat_no                                    = theme.dir .. "/icons/info/battery_empty.png"
theme.play                                      = theme.dir .. "/icons/info/play.png"
theme.pause                                     = theme.dir .. "/icons/info/pause.png"
theme.stop                                      = theme.dir .. "/icons/info/stop.png"
theme.mem                                       = theme.dir .. "/icons/info/mem.png"
theme.cpu                                       = theme.dir .. "/icons/info/cpu.png"
theme.net                                       = theme.dir .. "/icons/info/net.png"

theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

local infobar_width = dpi(50)
local infobar_height = dpi(1)


-- Textclock
os.setlocale(os.getenv("LANG")) -- to localize the clock
local mytextclock = wibox.widget.textclock(" <span fgcolor='#d5c4a1'>%A, %Y-%m-%d <b>%H:%M</b></span> ")
mytextclock.font = theme.font

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { mytextclock },
    three = true,
    week_number = "left",
    icons = "",
    notification_preset = {
        font = theme.font,
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})


-- Battery
local baticon = wibox.widget.imagebox(theme.bat)
local batbar = wibox.widget {
    forced_height    = infobar_height,
    forced_width     = infobar_width,
    color            = theme.fg_normal,
    background_color = theme.bg_normal,
    margins          = 1,
    paddings         = 1,
    ticks            = true,
    ticks_size       = dpi(6),
    widget           = wibox.widget.progressbar,
}
local batupd = lain.widget.bat({
    settings = function()
        if (not bat_now.status) or bat_now.status == "N/A" or type(bat_now.perc) ~= "number" then return end

        if bat_now.status == "Charging" then
            baticon:set_image(theme.ac)
            if bat_now.perc >= 98 then
                batbar:set_color(colors.green_1)
            elseif bat_now.perc > 50 then
                batbar:set_color(theme.fg_normal)
            elseif bat_now.perc > 15 then
                batbar:set_color(theme.fg_normal)
            else
                batbar:set_color(colors.red_1)
            end
        else
            if bat_now.perc >= 98 then
                batbar:set_color(colors.green_1)
            elseif bat_now.perc > 50 then
                batbar:set_color(theme.fg_normal)
                baticon:set_image(theme.bat)
            elseif bat_now.perc > 15 then
                batbar:set_color(theme.fg_normal)
                baticon:set_image(theme.bat_low)
            else
                batbar:set_color(colors.red_1)
                baticon:set_image(theme.bat_no)
            end
        end
        batbar:set_value(bat_now.perc / 100)
    end
})
local batbg = wibox.container.background(batbar, "#474747", gears.shape.rectangle)
local batwidget = wibox.container.margin(batbg, dpi(2), dpi(7), dpi(4), dpi(4))


-- Volume bar
local volicon = wibox.widget.imagebox(theme.vol)
theme.volume = lain.widget.pulsebar {
    width = infobar_width,
    border_width = 0,
    ticks = true,
    ticks_size = dpi(6),
    notification_preset = { font = theme.font },
    settings = function()
        if volume_now.level == nil then
            return
        end
        if volume_now.status == "off" then
            volicon:set_image(theme.vol_mute)
        elseif volume_now.level == 0 then
            volicon:set_image(theme.vol_no)
        elseif volume_now.level <= 50 then
            volicon:set_image(theme.vol_low)
        else
            volicon:set_image(theme.vol)
        end
    end,
    colors = {
        background   = theme.bg_normal,
        mute         = colors.red_1,
        unmute       = theme.fg_normal
    }
}
theme.volume.tooltip.wibox.fg = theme.fg_focus
theme.volume.bar:buttons(my_table.join (
        awful.button({}, 1, function()
            awful.spawn(string.format("%s -e pulsemixer", awful.util.terminal))
        end),
        awful.button({}, 2, function()
            os.execute(string.format("pactl set-sink-volume %d 100%%", theme.volume.device))
            theme.volume.update()
        end),
        awful.button({}, 3, function()
            os.execute(string.format("pactl set-sink-mute %d toggle", theme.volume.device))
            theme.volume.update()
        end),
        awful.button({}, 4, function()
            os.execute(string.format("pactl set-sink-volume %d +5%%", theme.volume.device))
            theme.volume.update()
        end),
        awful.button({}, 5, function()
            os.execute(string.format("pactl set-sink-volume %d -5%%", theme.volume.device))
            theme.volume.update()
        end)
))
local volumebg = wibox.container.background(theme.volume.bar, "#474747", gears.shape.rectangle)
local volumewidget = wibox.container.margin(volumebg, dpi(2), dpi(7), dpi(4), dpi(4))


-- Memory
local memicon = wibox.widget.imagebox(theme.mem)
local membar = wibox.widget {
    forced_height    = infobar_height,
    forced_width     = infobar_width,
    color            = theme.fg_normal,
    background_color = theme.bg_normal,
    margins          = 1,
    paddings         = 1,
    ticks            = true,
    ticks_size       = dpi(6),
    widget           = wibox.widget.progressbar,
}
local memupd = lain.widget.mem({
    timeout = 5,
    settings = function()
        membar:set_value(mem_now.perc / 100)
    end
})
local membg = wibox.container.background(membar, "#474747", gears.shape.rectangle)
local memwidget = wibox.container.margin(membg, dpi(2), dpi(7), dpi(4), dpi(4))
local memwidget_tooltip = awful.tooltip {
    objects = { memwidget },
    timer_function = function()
        return markup.font(theme.font, markup.fg.color(theme.fg_normal, " used: " .. mem_now.used .. "MB, free: " .. mem_now.free .. "MB, total: " .. mem_now.total .. "MB "))
    end,
}


-- CPU
local cpuicon = wibox.widget.imagebox(theme.cpu)
local cpubar = wibox.widget {
    forced_height    = infobar_height,
    forced_width     = infobar_width,
    color            = theme.fg_normal,
    background_color = theme.bg_normal,
    margins          = 1,
    paddings         = 1,
    ticks            = true,
    ticks_size       = dpi(6),
    widget           = wibox.widget.progressbar,
}
local cpuupd = lain.widget.cpu({
    timeout = 5,
    settings = function()
        cpubar:set_value(cpu_now.usage / 100)
    end
})
local cpubg = wibox.container.background(cpubar, "#474747", gears.shape.rectangle)
local cpuwidget = wibox.container.margin(cpubg, dpi(2), dpi(7), dpi(4), dpi(4))
local cpuwidget_tooltip = awful.tooltip {
    objects = { cpuwidget },
    timer_function = function()
        return nil
        --return markup.font(theme.font, markup.fg.color(theme.fg_normal, " " .. load_1 .. " " .. load_5 .. " " .. load_15 .. " "))
    end,
}

-- Weather
theme.weather = lain.widget.weather({
    city_id = 2950159, -- Berlin
})


-- Network
function round(num, idp)
    return tonumber(string.format("%." .. (idp or 0) .. "f", num))
end

function formatbytes(bytes)
    bytes = tonumber(bytes)
    kilobyte = 1024;
    megabyte = kilobyte * 1024;
    gigabyte = megabyte * 1024;
    terabyte = gigabyte * 1024;
    if((bytes >= 0) and (bytes < kilobyte)) then
        return bytes;
    elseif((bytes >= kilobyte) and (bytes < megabyte)) then
        return round(bytes / kilobyte, 1) .. 'k';
    elseif((bytes >= megabyte) and (bytes < gigabyte)) then
        return round(bytes / megabyte, 2) .. 'm';
    elseif((bytes >= gigabyte) and (bytes < terabyte)) then
        return round(bytes / gigabyte, 2) .. 'g';
    else
        return bytes;
    end
end

local net = lain.widget.net({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, " " .. formatbytes(net_now.received) .. " ↓↑ " .. formatbytes(net_now.sent) .. " "))
        --widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, " " .. net_now.received .. " ↓↑ " .. net_now.sent .. " "))
    end
})


-- Spacing
local space = wibox.widget.separator {
    orientation = "vertical",
    forced_width = 4,
    thickness = 4,
    color = "#00000000",
}

-- Separator
local vert_sep = wibox.widget.separator {
    orientation = "vertical",
    forced_width = theme.border,
    thickness = theme.border,
    color = colors.bw_2,
}


-- Eminent-like task filtering
local orig_filter = awful.widget.taglist.filter.all
-- Taglist label functions
awful.widget.taglist.filter.all = function (t, args)
    if t.selected or #t:clients() > 0 then
        return orig_filter(t, args)
    end
end


-- Create the layout
function theme.at_screen_connect(s)
    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create the wibox
    s.mywibox = awful.wibar {
        position = "top",
        screen = s,
        height = theme.bar_height + theme.border,
        bg = theme.bar_bg,
        fg = theme.bar_fg
    }

    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
            awful.button({}, 1, function () awful.layout.inc( 1) end),
            awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
            awful.button({}, 3, function () awful.layout.inc(-1) end),
            awful.button({}, 4, function () awful.layout.inc( 1) end),
            awful.button({}, 5, function () awful.layout.inc(-1) end)))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = awful.util.taglist_buttons
    }

    -- Create a tasklist widget
    --s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

     -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = awful.util.tasklist_buttons,
        bg_focus = theme.tasklist_bg_focus,
        widget_template = {
            {
                {
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 10,
                right = 10,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
        },
    }

    -- Add widgets to the wibox
    s.mywibox:setup {
        {
            layout = wibox.layout.flex.vertical,
            {
                layout = wibox.layout.align.horizontal,
                {
                    -- Left widgets
                    layout = wibox.layout.fixed.horizontal,
                    space,
                    {
                        -- Layoutbox
                        {
                            s.mylayoutbox,
                            left = 2,
                            top = 3,
                            bottom = 3,
                            widget = wibox.container.margin,
                        },
                        bg = theme.bar_bg,
                        widget = wibox.container.background,
                    },
                    space,
                    {
                        -- Taglist
                        {
                            s.mytaglist,
                            left = 2,
                            right = 2,
                            widget = wibox.container.margin,
                        },
                        bg = theme.bar_bg,
                        widget = wibox.container.background,
                    },
                    space, vert_sep, space,
                    s.mypromptbox,
                },
                {
                    -- Middle
                    {
                        s.mytasklist,
                        left = 2,
                        right = 2,
                        widget = wibox.container.margin,
                    },
                    bg = theme.bar_bg,
                    widget = wibox.container.background,
                },
                {
                    -- Right widgets
                    layout = wibox.layout.fixed.horizontal,
                    space, vert_sep, space,
                    neticon, net,
                    space, vert_sep, space,
                    memicon, memwidget,
                    cpuicon, cpuwidget,
                    baticon, batwidget,
                    volicon, volumewidget,
                    --wibox.widget.systray(),
                    space, vert_sep, space,
                    mytextclock,
                },
            },
        },
        id = "border",
        bottom = s.mywibox.position == "top" and theme.border or 0,
        top = s.mywibox.position == "bottom" and theme.border or 0,
        color = colors.bw_2,
        widget = wibox.container.margin,
    }
end

return theme