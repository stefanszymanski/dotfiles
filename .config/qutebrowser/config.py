from os.path import expanduser
config.source(expanduser('~/.config/qutebrowser/theme.py'))


terminal = 'termite'

#############
# Behaviour #
#############

# caching and persistence
c.content.cache.appcache = True
c.content.cache.maximum_pages = 0
c.content.cache.size = None
c.content.canvas_reading = True
c.content.cookies.accept = 'no-3rdparty'
c.content.cookies.store = True
c.content.local_storage = True
c.content.persistent_storage = 'ask'
c.content.dns_prefetch = True

# misc
c.confirm_quit = ['downloads']
c.content.autoplay = False
c.content.default_encoding = 'utf-8'
c.content.frame_flattening = False
c.content.images = True
c.content.webgl = True
c.content.mute = False
c.content.print_element_backgrounds = False
c.content.fullscreen.window = False
c.keyhint.delay = 500
c.prompt.filebrowser = True
c.search.incremental = True
c.spellcheck.languages = ['en-US', 'de-DE']
c.zoom.text_only = False

# tabs
c.tabs.background = True
c.tabs.last_close = 'startpage'
c.tabs.new_position.related = 'next'
c.tabs.new_position.stacking = True
c.tabs.new_position.unrelated = 'last'
c.tabs.pinned.frozen = False
c.tabs.pinned.shrink = True
c.tabs.select_on_remove = 'last-used'
c.tabs.show = 'multiple'
c.tabs.tabs_are_windows = False
c.tabs.wrap = True

# privacy and security
c.content.geolocation = 'ask'
c.content.host_blocking.enabled = True
c.content.hyperlink_auditing = False
c.content.desktop_capture = False
c.content.media_capture = False
c.content.plugins = False
c.content.mouse_lock = 'ask'
c.content.notifications = 'ask'
c.content.private_browsing = False
c.content.ssl_strict = True
c.content.xss_auditing = True

# javascript
c.content.javascript.enabled = True
c.content.javascript.alert = True
c.content.javascript.can_access_clipboard = False
c.content.javascript.can_close_tabs = False
c.content.javascript.can_open_tabs_automatically = False
c.content.javascript.modal_dialog = False
c.content.javascript.prompt = True

# headers
c.content.headers.accept_language = 'en-US,en,de-DE,de'
c.content.headers.do_not_track = True
c.content.headers.referer = 'same-domain'

# downloads
c.downloads.location.directory = '~/downloads'
c.downloads.location.prompt = False
c.downloads.location.remember = True
c.downloads.location.suggestion = 'filename'
c.downloads.open_dispatcher = '{} -e "vifm --select {{}}"'.format(terminal)
c.downloads.position = 'bottom'
c.downloads.remove_finished = -1

# editor
c.editor.command = [terminal, '-e', 'nvim', '{}']
c.editor.encoding = 'utf-8'

# insert mode
c.input.insert_mode.auto_enter = True
c.input.insert_mode.auto_leave = True
c.input.insert_mode.auto_load = False
c.input.insert_mode.leave_on_load = True
c.input.insert_mode.plugins = False

# misc input
c.input.links_included_in_focus_chain = False
c.input.partial_timeout = 2500
c.input.rocker_gestures = False
c.input.spatial_navigation = False

# session
c.auto_save.session = True
c.auto_save.interval = 60000
c.session.lazy_restore = True

# mouse support
c.tabs.close_mouse_button = 'middle'
c.tabs.close_mouse_button_on_bar = 'ignore'
c.tabs.mousewheel_switching = False

# search
c.url.auto_search = 'naive'
c.url.searchengines = {
    'DEFAULT': 'https://google.com/search?q={}',
    'd': 'https://duckduckgo.com/?q={}',
    'y': 'https://youtube.com/results?search_query={}',
    'l': 'https://dict.leo.org/?search={}'
}


##############
# Appearance #
##############

# fonts
c.fonts.default_family = 'Monospace'
c.fonts.contextmenu = 'Monospace'

# no scrollbars
c.scrolling.bar = 'never'
c.completion.scrollbar.width = 0
c.completion.scrollbar.padding = 0
c.scrolling.smooth = False

# no rounded corners
c.keyhint.radius = 0
c.prompt.radius = 0

# statusbar
c.statusbar.hide = False
c.statusbar.position = 'bottom'
c.statusbar.padding = {'bottom': 2, 'top': 2, 'left': 0, 'right': 0}

# tabs
c.tabs.position = 'top'
c.tabs.padding = {'bottom': 2, 'top': 2, 'left': 8, 'right': 8}
c.tabs.title.alignment = 'left'
c.tabs.title.format = '{audio}{index}: {current_title}'
c.tabs.title.format_pinned = '{audio}{index}'
c.tabs.indicator.width = 0


############
# Bindings #
############

# remove bindings I may press by accident
config.unbind('d', mode='normal')
config.unbind('<Ctrl-q>')

c.bindings.commands = {
    'normal': {
        # clone the current tab
        '<Ctrl-Shift-T>': 'tab-clone',
        # open link in VLC
        ';m': 'hint links spawn mpv {hint-url}',
        ';M': 'hint --rapid links spawn mpv {hint-url}',
        # open link in a new window
        ';w': 'hint links run :open -w {hint-url}',
        # open link in a new window
        ';p': 'hint links run :open -p {hint-url}',
        # open link in a new window
        '<Alt-p>p': 'spawn --userscript qute-pass',
        '<Alt-p>o': 'spawn --userscript qute-pass --username-only',
        '<Alt-p>l': 'spawn --userscript qute-pass --password-only',
        # edit URL
        'eo': 'set-cmd-text -s :open {url}',
        # edit URL and open in new tab
        'eO': 'set-cmd-text -s :open -t {url}',
        # open developer tools
        '<F12>': 'inspector',
    },
    'insert': {
        # readline: moving
        '<Ctrl-a>': 'fake-key <Home>',
        '<Ctrl-e>': 'fake-key <End>',
        '<Ctrl-f>': 'fake-key <Right>',
        '<Ctrl-b>': 'fake-key <Left>',
        '<Ctrl-n>': 'fake-key <Down>',
        '<Ctrl-p>': 'fake-key <Up>',
        '<Alt-f>':  'fake-key <Ctrl-Right>',
        '<Alt-b>':  'fake-key <Ctrl-Left>',
        # readline: killing and yanking
        '<Ctrl-d>': 'fake-key <Delete>',
        '<Alt-d>':  'fake-key <Ctrl-Delete>',
        '<Ctrl-w>': 'fake-key <Ctrl-Backspace>',
        '<Alt-Backspace>': 'fake-key <Ctrl-Backspace>',
        '<Ctrl-y>': 'insert-text {primary}',
    }
}

c.bindings.commands['passthrough'] = c.bindings.commands['insert']

###########
# Aliases #
###########

c.aliases['c'] = 'tab-close'
