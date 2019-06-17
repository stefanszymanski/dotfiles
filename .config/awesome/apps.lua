-- globals
local format = string.format
-- libraries
local awful  = require("awful")
local spawn  = awful.spawn.with_shell


local function default_open_factory(cmd)
    return function(file)
        spawn(format("%s %s", cmd, file))
    end
end

local function default_open_cmd_factory(cmd)
    return function(file)
        return format("%s %s", cmd, file)
    end
end

local function run_factory(cmd)
    return function()
        spawn(cmd)
    end
end

local function terminal_open_cmd_factory(terminal)
    return function(cmd)
        return format("%s -e %s", terminal, cmd)
    end
end

local terminal = "urxvtc"
local editor   = os.getenv("EDITOR") or "nvim"
local cmd = {
    terminal     = terminal,
    editor       = terminal_open_cmd_factory(terminal)(editor),
    browser      = "firefox",
    screenlocker = "$HOME/.scripts/lockscreen.sh",
    filemanager  = terminal .. " -e ranger",
    mail         = terminal .. " -e mutt",
    imageviewer  = "feh",
    imageeditor  = "pinta",
}

local apps = {}

apps.editor = {
    cmd = cmd.editor,
    open = default_open_factory(cmd.editor),
    open_cmd = default_open_cmd_factory(cmd.editor),
}

apps.filemanager = {
    cmd = cmd.filemanager,
    open = function(file) spawn(format("%s --selectfile %s", cmd.filemanager, file)) end,
}

apps.imageviewer = {
    cmd = cmd.imageviewer,
    open = default_open_factory(cmd.imageviewer),
}

apps.imageeditor = {
    cmd = cmd.imageeditor,
    open = default_open_factory(cmd.imageeditor),
}

apps.mail = {
    cmd = cmd.mail,
}

apps.screenlocker = {
    cmd = cmd.screenlocker,
}

apps.browser = {
    cmd = cmd.browser,
}

apps.terminal = {
    cmd = cmd.terminal,
    open_cmd = terminal_open_cmd_factory(cmd.terminal)
}

-- add a run function for each app
for k,app in pairs(apps) do
    apps[k].run = run_factory(app.cmd)
end

return apps
