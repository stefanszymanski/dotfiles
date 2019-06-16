local awful     = require("awful")
local gears     = require("gears")
local naughty   = require("naughty")
local util      = require("custom.util")
local string    = string

local screenshot = {}

local default_args = {
    dir                      = "~/screenshots",
    display_notification     = true,
    -- the following options are used only when notifications are enabled
    thumb_dir                = "/tmp",
    create_thumb             = true,
    keep_thumbs              = false,
    thumb_width              = 480,
    thumb_height             = 320,
    run_factory              = nil,
    actions_factory          = nil,

}
default_args.notification_preset = {
    icon_size   = 480,
    max_width   = 1400,
}

screenshot.defaults = {}

local function get_args(args)
    return gears.table.join(default_args, screenshot.defaults or {}, args or {})
end

local function get_cmd(scrot_cmd, args)
    local cmd = nil
    if args.create_thumb then
        cmd = string.format("%s -e 'convert $f -adaptive-resize %sx%s %s/thumb-$n && mv $f %s/ && echo $n'",
            scrot_cmd, args.thumb_width, args.thumb_height, args.thumb_dir, args.dir)
    else
        cmd = string.format("%s -e 'mv $f %s/ && echo $n'", scrot_cmd, args.dir)
    end
    return cmd
end

local function get_actions(path, args)
    local actions = nil
    if type(args.actions_factory) == "function" then
        actions = args.actions_factory(path, args)
    end
    return actions
end

local function get_run(path, args)
    local run = nil
    if type(args.run_factory) == "function" then
        run = args.run_factory(path, args)
    end
    return run
end

local function get_thumb_path(filename, args)
    local path = nil
    if args.create_thumb then
        path = string.format("%s/thumb-%s", args.thumb_dir, filename)
    end
    return path
end

-- Takes a screenshot, creates a thumbnail and displays a notification
local function make_screenshot(scrot_cmd, notification_title, args)
    args = get_args(args)
    local cmd = get_cmd(scrot_cmd, args)
    awful.spawn.easy_async_with_shell(cmd, function(stdout)
        local filename = util.string.trim(stdout)
        local path = string.format("%s/%s",args.dir, filename)
        if args.display_notification then
            local thumb_path = get_thumb_path(filename, args)
            naughty.notify { 
                title = notification_title, 
                text = path, 
                icon = thumb_path, 
                run = get_run(path, args),
                actions = get_actions(path, args),
                preset = args.notification_preset or {}
            }
            if not args.keep_thumbs then
                awful.spawn("rm " .. thumb_path)
            end
        end
    end)
end

screenshot.screen = function(args, title)
    make_screenshot(
        "scrot 'screenshot-screen_%Y-%m-%d_%H-%M-%S_$wx$h.png'",
        title or "Saved screenshot of full screen",
        args
    )
end

screenshot.focused = function(args, title)
    make_screenshot(
        "scrot --focused 'screenshot-focused_%Y-%m-%d_%H-%M-%S_$wx$h.png'",
        title or "Saved screenshot of current window",
        args
    )
end

screenshot.selection = function(args, title)
    make_screenshot(
        "sleep 0.1 && scrot -s 'screenshot-selection_%Y-%m-%d_%H-%M-%S_$wx$h.png'",
        title or "Saved screenshot of selected area",
        args
    )
end

return screenshot
