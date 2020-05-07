import os

# load my custom default configuration
dir = os.path.expanduser('~/.config/qutebrowser/')
config.source(os.path.join(dir, 'settings.py'))
config.source(os.path.join(dir, 'theme.py'))

# set a different session name
c.session.default_name = 'work'

# disable host blocking
c.content.host_blocking.enabled = False
