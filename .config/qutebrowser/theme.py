# Gruvbox dark, medium scheme by Dawid Kurek (dawikur@gmail.com), morhetz (https://github.com/morhetz/gruvbox)

# ============== #
# Gruvbox colors #
# ============== #

dark0 = "#282828"
dark1 = "#3c3836"
dark2 = "#504945"
dark3 = "#665c54"
dark4 = "#7c6f64"
dark_gray = "#928374"

light0 = "#fbf1c7"
light1 = "#ebdbb2"
light2 = "#d5c4a1"
light3 = "#bdae93"
light4 = "#a89984"
light_gray = "#928374"

bright_red = "#fb4934"
bright_green = "#b8bb26"
bright_yellow = "#fabd2f"
bright_blue = "#83a598"
bright_purple = "#d3869b"
bright_aqua = "#8ec07c"
bright_orange = "#fe8019"

neutral_red = "#cc241d"
neutral_green = "#98971a"
neutral_yellow = "#d79921"
neutral_blue = "#458588"
neutral_purple = "#b16286"
neutral_aqua = "#689d6a"
neutral_orange = "#d65d0e"

faded_red = "#9d0006"
faded_green = "#79740e"
faded_yellow = "#b57614"
faded_blue = "#076678"
faded_purple = "#8f3f71"
faded_aqua = "#427b58"
faded_orange = "#af3a03"


# ================== #
# Gruvbox dark theme #
# ================== #

bg0 = dark0
bg1 = dark1
bg2 = dark2
bg3 = dark3
bg4 = dark4

fg0 = light0
fg1 = light1
fg2 = light2
fg3 = light3
fg4 = light4

gray = dark_gray
red = bright_red
green = bright_green
yellow = bright_yellow
blue = bright_blue
purple = bright_purple
aqua = bright_aqua
orange = bright_orange


# ========================== #
# Qutebrowser color settings #
# ========================== #

c.colors.webpage.prefers_color_scheme_dark = True

# Completion
c.colors.completion.fg = fg2
c.colors.completion.odd.bg = bg3
c.colors.completion.even.bg = bg0
c.colors.completion.category.fg = yellow
c.colors.completion.category.bg = bg0
c.colors.completion.category.border.top = bg0
c.colors.completion.category.border.bottom = bg0
c.colors.completion.item.selected.fg = bg1
c.colors.completion.item.selected.bg = yellow
c.colors.completion.item.selected.border.top = yellow
c.colors.completion.item.selected.border.bottom = yellow
c.colors.completion.match.fg = green
c.colors.completion.scrollbar.fg = fg2
c.colors.completion.scrollbar.bg = bg0

# Downloads
c.colors.downloads.bar.bg = bg0
c.colors.downloads.start.fg = bg0
c.colors.downloads.start.bg = blue
c.colors.downloads.stop.fg = bg0
c.colors.downloads.stop.bg = aqua
c.colors.downloads.error.fg = red

# Hints
c.colors.hints.fg = bg0
c.colors.hints.bg = yellow
c.colors.hints.match.fg = fg2

# Keyhint
c.colors.keyhint.fg = fg2
c.colors.keyhint.suffix.fg = fg2
c.colors.keyhint.bg = bg0

# Messages
c.colors.messages.error.fg = bg0
c.colors.messages.error.bg = red
c.colors.messages.error.border = red
c.colors.messages.warning.fg = bg0
c.colors.messages.warning.bg = purple
c.colors.messages.warning.border = purple
c.colors.messages.info.fg = fg2
c.colors.messages.info.bg = bg0
c.colors.messages.info.border = bg0

# Prompts
c.colors.prompts.fg = fg2
c.colors.prompts.border = bg0
c.colors.prompts.bg = bg0
c.colors.prompts.selected.bg = yellow

# Status bar
c.colors.statusbar.normal.fg = green
c.colors.statusbar.normal.bg = bg0
c.colors.statusbar.insert.fg = bg0
c.colors.statusbar.insert.bg = blue
c.colors.statusbar.passthrough.fg = bg0
c.colors.statusbar.passthrough.bg = aqua
c.colors.statusbar.private.fg = bg0
c.colors.statusbar.private.bg = bg3
c.colors.statusbar.command.fg = fg2
c.colors.statusbar.command.bg = bg0
c.colors.statusbar.command.private.fg = fg2
c.colors.statusbar.command.private.bg = bg0
c.colors.statusbar.caret.fg = bg0
c.colors.statusbar.caret.bg = purple
c.colors.statusbar.caret.selection.fg = bg0
c.colors.statusbar.caret.selection.bg = blue
c.colors.statusbar.progress.bg = blue
c.colors.statusbar.url.fg = fg2
c.colors.statusbar.url.error.fg = red
c.colors.statusbar.url.hover.fg = fg2
c.colors.statusbar.url.success.http.fg = aqua
c.colors.statusbar.url.success.https.fg = green
c.colors.statusbar.url.warn.fg = purple

# Tab bar
c.colors.tabs.bar.bg = bg0

# Tab indicators
c.colors.tabs.indicator.start = blue
c.colors.tabs.indicator.stop = aqua
c.colors.tabs.indicator.error = red

# Tabs
c.colors.tabs.odd.bg = bg0
c.colors.tabs.odd.fg = fg2
c.colors.tabs.even.bg = bg0
c.colors.tabs.even.fg = fg2
c.colors.tabs.pinned.even.bg = bg0
c.colors.tabs.pinned.even.fg = fg2
c.colors.tabs.pinned.odd.bg = bg0
c.colors.tabs.pinned.odd.fg = fg2

# Selected tabs
c.colors.tabs.selected.odd.bg = yellow
c.colors.tabs.selected.odd.fg = bg0
c.colors.tabs.selected.even.bg = yellow
c.colors.tabs.selected.even.fg = bg0
c.colors.tabs.pinned.selected.odd.bg = yellow
c.colors.tabs.pinned.selected.odd.fg = bg0
c.colors.tabs.pinned.selected.even.bg = yellow
c.colors.tabs.pinned.selected.even.fg = bg0

# Context menu
c.colors.contextmenu.menu.bg = bg1
c.colors.contextmenu.menu.fg = fg1
c.colors.contextmenu.selected.bg = yellow
c.colors.contextmenu.selected.fg = bg0
