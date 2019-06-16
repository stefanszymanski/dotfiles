local awful  = require("awful")
local format = string.format
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

local terminal = "urxvtc"
local cmd = {
    terminal     = terminal,
    editor       = os.getenv("EDITOR") or "nvim",
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
    get_open_cmd = default_open_cmd_factory(cmd.editor),
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
    get_open_cmd = function(command)
        return format("%s -e '%s'", cmd.terminal, command)
    end,
}

return apps
