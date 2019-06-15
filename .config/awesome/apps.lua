local terminal = "urxvtc"

local apps = {
    terminal     = terminal,
    editor       = os.getenv("EDITOR") or "nvim",
    browser      = "firefox",
    screenlocker = "$HOME/.scripts/lockscreen.sh",
    filemanager  = terminal .. " -e ranger",
    mailcient    = terminal .. " -e mutt",
    imageviewer  = "feh",
    imageeditor  = "pinta",
}

return apps
