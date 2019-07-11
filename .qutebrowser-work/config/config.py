from os.path import expanduser

# load my custom default configuration
config.source(expanduser('~/.config/qutebrowser/config.py'))

# set a different session name
c.session.default_name = 'work'
