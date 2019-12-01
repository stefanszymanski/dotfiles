--[[
     Custom Layout One (still wip)

     Future features
     - popups for widgets (network, battery)
     - Layout list
--]]


local gears 	= require("gears")
local lain  	= require("lain")
local awful 	= require("awful")
local wibox 	= require("wibox")
local naughty 	= require("naughty")
local dpi   	= require("beautiful.xresources").apply_dpi
local custom	= require("custom")

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
theme.wallpaper_fn								= gears.wallpaper.tiled

local font_name                                 = "monospace"
local font_size                                 = "10"
theme.font                                      = font_name .. " " ..                         font_size
theme.font_bold                                 = font_name .. " " .. "Bold"        .. " " .. font_size
theme.font_italic                               = font_name .. " " .. "Italic"      .. " " .. font_size
theme.font_bold_italic                          = font_name .. " " .. "Bold Italic" .. " " .. font_size
theme.font_big                                  = font_name .. " " .. "Bold" .. " 16"

theme.accent                                    = colors.red_2
theme.border_normal                             = colors.bw_2
theme.border_focus                              = colors.bw_5
theme.border_marked                             = colors.bw_5

-- TODO adjust?
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

theme.taglist_font = theme.font_bold
theme.taglist_bg_focus = colors.yellow_1
theme.taglist_fg_focus = colors.black_1
theme.taglist_bg_normal = colors.bw_1
theme.taglist_fg_normal = colors.white_1
theme.taglist_bg_occupied = colors.bw_1
theme.taglist_fg_occupied = colors.white_1
theme.taglist_bg_empty = colors.bw_2
theme.taglist_fg_empty = colors.white_1
theme.taglist_bg_urgent = colors.orange_1
theme.taglist_fg_urgent = colors.black_1
theme.taglist_bg_volatile = colors.red_1
theme.taglist_fg_volatile = colors.black_1

theme.tasklist_font_normal = theme.font
theme.tasklist_font_focus = theme.font_bold
theme.tasklist_font_minimized = theme.font
theme.tasklist_font_urgent = theme.font_bold
theme.tasklist_bg_focus = colors.yellow_1
theme.tasklist_fg_focus = colors.black_1
theme.tasklist_bg_normal = colors.bw_1
theme.tasklist_fg_normal = colors.white_1
theme.tasklist_bg_minimize = colors.bw_2
theme.tasklist_fg_minimize = colors.white_1
theme.tasklist_bg_urgent = colors.orange_1
theme.tasklist_fg_urgent = colors.black_1
theme.tasklist_plain_task_name = true
-- theme.tasklist_disable_task_name = true

theme.tasklist_shape_border_color               = colors.purple_2
theme.tasklist_shape_border_color_focus         = colors.green_2
theme.tasklist_shape_border_color_minimized     = colors.blue_2
theme.tasklist_shape_border_color_urgent        = colors.red_2

theme.hotkeys_border_width                      = theme.border
theme.hotkeys_border_color                      = colors.bw_5
theme.hotkeys_group_margin                      = 50

theme.prompt_bg                                 = colors.bw_1
theme.prompt_fg                                 = theme.fg_normal
theme.prompt_border_color                       = colors.bw_2
theme.bg_systray                                = colors.bw_0
theme.bg_systray                                = colors.bw_1

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

theme.bar_height                                = 16

theme.notification_fg                           = theme.fg_normal
theme.notification_bg                           = theme.bg_normal
theme.notification_border_color                 = colors.bw_2
theme.notification_border_width                 = theme.border
theme.notification_icon_size                    = 80
theme.notification_opacity                      = 1
theme.notification_max_width                    = 800
theme.notification_max_height                   = 400
theme.notification_margin                       = 10
theme.notification_shape                        = function(cr, w, h)
                                                      gears.shape.rounded_rect(cr, w, h, theme.border_radius or 0)
												  end

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
theme.redshift_on								= theme.dir .. "/icons/info/redshift-on.svg"
theme.redshift_off								= theme.dir .. "/icons/info/redshift-off.svg"

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

local infobar_width = 50
local infobar_height = 1

naughty.config.padding                          = 6
naughty.config.spacing                          = 6
naughty.config.defaults.timeout                 = 10
naughty.config.defaults.font                    = theme.font
naughty.config.defaults.fg                      = theme.notification_fg
naughty.config.defaults.bg                      = theme.notification_bg
naughty.config.defaults.border_width            = theme.notification_border_width
naughty.config.defaults.margin 					= theme.notification_margin

naughty.config.presets.normal                   = {
                                                      font         = theme.font,
                                                      fg           = theme.notification_fg,
                                                      bg           = theme.notification_bg,
                                                      border_width = theme.notification_border_width,
                                                      margin       = theme.notification_margin,
                                                  }

naughty.config.presets.low                      = {
                                                      font         = theme.font,
                                                      fg           = theme.notification_fg,
                                                      bg           = theme.notification_bg,
                                                      border_width = theme.notification_border_width,
                                                      margin       = theme.notification_margin,
                                                  }

naughty.config.presets.ok                       = {
                                                      font         = theme.font,
                                                      fg           = colors.aqua_2,
                                                      bg           = theme.notification_bg,
                                                      border_width = theme.notification_border_width,
                                                      margin       = theme.notification_margin,
                                                      timeout      = 0,
                                                  }

naughty.config.presets.info                     = {
                                                      font         = theme.font,
                                                      fg           = colors.blue_2,
                                                      bg           = theme.notification_bg,
                                                      border_width = theme.notification_border_width,
                                                      margin       = theme.notification_margin,
                                                      timeout      = 0,
                                                  }

naughty.config.presets.warn                     = {
                                                      font         = theme.font,
                                                      fg           = colors.yellow_2,
                                                      bg           = theme.notification_bg,
                                                      border_width = theme.notification_border_width,
                                                      margin       = theme.notification_margin,
                                                      timeout      = 0,
                                                  }

naughty.config.presets.critical                 = {
                                                      font         = theme.font,
                                                      fg           = colors.red_2,
                                                      bg           = theme.notification_bg,
                                                      border_width = theme.notification_border_width,
                                                      margin       = theme.notification_margin,
                                                      timeout      = 0,
	                                              }

-- Floating prompt box
theme.prompt = custom.prompt.promptbox({ 
    border_color = colors.bw_2,
    bg = colors.bw_1,
})


-- Floating lua prompt box
theme.luaprompt = custom.prompt.luapromptbox({
    border_color = colors.bw_2,
    bg = colors.bw_1,
})

-- Drink reminder
local preset = {
    font = "monospace Bold 24",
    position = "top_middle",
    timeout = 0,
    margin = 20,
    fg = colors.red_1,
    bg = colors.bw_9,
    border_width = 4,
}
local drink_reminder = custom.widget.reminder {
    --text = "  ⊻    ",
    text = " ⊻  ",
    interval = 3600,
    preset = preset,
}


-- Date and time widgets
os.setlocale(os.getenv("LANG")) -- to localize the clock
local datewidget = wibox.widget {
    {
        {
            widget = wibox.widget.textclock,
            font = theme.font,
            format = "%A, %Y-%m-%d"
        },
        right = 8,
        left = 8,
        widget = wibox.container.margin
    },
    fg = colors.black_1,
    bg = colors.blue_2,
    widget = wibox.container.background
}
local timewidget = wibox.widget {
    {
        {
            widget = wibox.widget.textclock,
            font = theme.font_bold,
            format = "%H:%M"
        },
        right = 8,
        left = 8,
        widget = wibox.container.margin
    },
    fg = colors.black_1,
    bg = colors.blue_2,
    widget = wibox.container.background
}

-- Calendar popup
theme.cal = lain.widget.cal({
    attach_to = { datewidget },
    followtag = true,
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
local batwidget = wibox.container.margin(batbg, dpi(2), dpi(7), dpi(3), dpi(3))


-- Volume widget
theme.volume = lain.widget.pulse {
    timeout = 5,
	settings = function()
        if volume_now.index == nil then
            widget:set_markup("vol n/a")
        else
            if volume_now.left == volume_now.right then
                volume = volume_now.left
            else
                volume = volume_now.left .. "/" .. volume_now.right
            end
            if volume_now.muted == "yes" then
                widget:set_markup("<span strikethrough='true'>vol " .. volume .. "</span>")
            else
                widget:set_markup("vol " .. volume)
            end
        end
	end
}
local volumewidget = wibox.widget {
    {
        {
            widget = theme.volume.widget,
            font = theme.font,
        },
        widget = wibox.container.margin,
        left = 8,
        right = 8,
    },
    widget = wibox.container.background,
    bg = colors.bw_1,
    fg = theme.fg_normal,
}
volumewidget:buttons(my_table.join (
        awful.button({}, 1, function()
            awful.spawn(string.format("%s -e pulsemixer", awful.util.terminal))
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

-- Volume popup
local audioinfo = custom.widget.audioinfo({
    attach_to = { volumewidget },
    followtag = true,
    notification_preset = {
        font = theme.font,
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- override the volume widget's update function to also update the popup
local original_volume_update = theme.volume.update
theme.volume.update = function(cb)
    local callback = function()
        audioinfo.update()
        if type(cb) == "function" then cb() end
    end
    original_volume_update(callback)
end



-- Memory widget 
local mem = lain.widget.mem({
    timeout = 5,
    settings = function()
        widget:set_markup("mem " .. mem_now.perc .. "%")
    end
})
local memwidget = wibox.widget {
    {
        {
            widget = mem.widget,
            font = theme.font,
        },
        widget = wibox.container.margin,
        left = 8,
        right = 8,
    },
    widget = wibox.container.background,
    bg = colors.bw_1,
    fg = theme.fg_normal,
}


-- CPU widget
local cpu = lain.widget.cpu({
    timeout = 5,
    settings = function()
        widget:set_markup("cpu " .. cpu_now.usage .. "%")
    end
})
local cpuwidget = wibox.widget {
    {
        {
            widget = cpu.widget,
            font = theme.font,
        },
        widget = wibox.container.margin,
        left = 8,
        right = 8,
    },
    widget = wibox.container.background,
    fg = theme.fg_normal,
    bg = colors.bw_1,
}

-- Sysinfo popup
local sysinfo = custom.widget.sysinfo({
    attach_to = { memwidget, cpuwidget },
    followtag = true,
    notification_preset = {
        font = theme.font,
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

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
        widget:set_markup(formatbytes(net_now.received) .. " ↓↑ " .. formatbytes(net_now.sent))
        --widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, " " .. net_now.received .. " ↓↑ " .. net_now.sent .. " "))
    end
})

local netwidget = wibox.widget {
    {
        {
            widget = net.widget,
            font = theme.font,
        },
        widget = wibox.container.margin,
        left = 8,
        right = 8,
    },
    widget = wibox.container.background,
    bg = colors.bw_1,
    fg = theme.fg_normal,
}


-- Redshift widget
local redshift_checkbox = wibox.widget{
    checked      = false,
    check_color  = "#00000000",
    border_width = 0,
    shape        = gears.shape.square,
    widget       = wibox.widget.checkbox
}
local myredshift_icon = wibox.widget.imagebox(theme.redshift_on)
local redshiftwidget = wibox.widget {
    redshift_checkbox,
    myredshift_icon,
    layout = wibox.layout.stack
}
lain.widget.contrib.redshift:attach(
    redshift_checkbox,
    function (active)
        if active then
            myredshift_icon.image = theme.redshift_on
        else
            myredshift_icon.image = theme.redshift_off
        end
        redshift_checkbox.checked = active
    end
)


-- Spacing widget
local space = wibox.widget.separator {
    orientation = "vertical",
    forced_width = 4,
    thickness = 4,
    color = "#00000000",
}


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

    -- Create the wibox
    s.mywibox = awful.wibar {
        position = "top",
        screen = s,
        height = theme.bar_height + theme.border,
        bg = theme.bar_bg,
        fg = theme.bar_fg
    }

    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
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
        buttons = awful.util.taglist_buttons,
        layout = {
            spacing = 4,
            layout = wibox.layout.fixed.horizontal
        },
        update_function = function(w, buttons, label, data, tags, args)
            local label2 = function(c, style)
                -- backup the tag name, prepend it with the tag index and
                -- restore it after the label was created
                local name_bkp = c.name or ""
                if c.name then
                    c.name = c.index .. " | " .. c.name
                else
                    c.name = c.index
                end
                local text, bg, bg_image, icon, item_args = label(c, style)
                c.name = name_bkp
                return text, bg, bg_image, icon, item_args
            end
            awful.widget.common.list_update(w, buttons, label2, data, tags, args)
        end,
        widget_template = {
            {
                {
                    id = "text_role",
                    widget = wibox.widget.textbox
                },
                widget = wibox.container.margin,
                left = 10,
                right = 10
            },
            id = "background_role",
            widget = wibox.container.background,
        }
    }

     -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.minimizedcurrenttags,
        buttons = awful.util.tasklist_buttons,
        bg_focus = theme.tasklist_bg_focus,
        layout = {
            spacing = 4,
            layout = wibox.layout.fixed.horizontal,
        },
        widget_template = {
            {
                {
                    {
                        id = "text_role",
                        widget = wibox.widget.textbox,
                    },
                    widget = wibox.container.constraint,
                    strategy = "max",
                    width = 200,
                },
                widget = wibox.container.margin,
                left = 10,
                right = 10,
            },
            id = 'background_role',
            widget = wibox.container.background,
        },
    }

    local systray = wibox.widget {
        {
            {
                redshiftwidget,
                wibox.widget.systray(),
                layout = wibox.layout.fixed.horizontal
            },
            widget = wibox.container.margin,
            left = 6,
            right = 6,
        },
        widget = wibox.container.background,
        bg = colors.bw_1,
        fg = theme.fg_normal,
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
                    {
                        -- Layoutbox
                        {
                            s.mylayoutbox,
                            left = 2,
                            top = 2,
                            bottom = 2,
                            widget = wibox.container.margin,
                        },
                        bg = colors.bw_0,
                        fg = colors.black_1,
                        widget = wibox.container.background,
                    },
                },
                {
                    -- Middle
                    layout = wibox.layout.fixed.horizontal,
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
                    space,
                    {
                        s.mytasklist,
                        left = 2,
                        right = 2,
                        widget = wibox.container.margin,
                    },
                },
                {
                    -- Right widgets
                    layout = wibox.layout.fixed.horizontal,
                    netwidget,
                    space,
                    memwidget,
                    space,
                    cpuwidget,
                    space,
                    -- batwidget,
                    -- space,
                    volumewidget,
                    space,
                    systray,
                    space,
                    datewidget,
                    space,
                    timewidget
                },
            },
        },
        -- id = "border",
        -- bottom = s.mywibox.position == "top" and theme.border or 0,
        -- top = s.mywibox.position == "bottom" and theme.border or 0,
        -- color = colors.bw_2,
        -- bg = colors.red_1,
        widget = wibox.container.background,
    }
end


theme.layoutlist = awful.widget.layoutlist {
    base_layout = wibox.widget {
        spacing         = 5,
        forced_num_cols = 5,
        layout          = wibox.layout.grid.vertical,
    },
    widget_template = {
        {
            {
                id            = 'icon_role',
                forced_height = 22,
                forced_width  = 22,
                widget        = wibox.widget.imagebox,
            },
            margins = 4,
            widget  = wibox.container.margin,
        },
        id              = 'background_role',
        forced_width    = 24,
        forced_height   = 24,
        shape           = gears.shape.rounded_rect,
        widget          = wibox.container.background,
    },
}

theme.layoutpopup = awful.popup {
    widget = wibox.widget {
        theme.layoutlist,
        margins = 4,
        widget  = wibox.container.margin,
    },
    border_color = theme.border_color,
    border_width = theme.border_width,
    placement    = awful.placement.centered,
    ontop        = true,
    visible      = false,
    shape        = gears.shape.rounded_rect
}

return theme
