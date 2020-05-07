import os

dir = os.path.expanduser('~/.config/qutebrowser/')

# load general settings and theme
config.source(os.path.join(dir, 'settings.py'))
config.source(os.path.join(dir, 'theme.py'))

# load jmatrix plugin
sys.path.append(os.path.join(dir, 'plugin/jmatrix'))
config.source(os.path.join(
    dir, 'plugin/jmatrix/jmatrix/integrations/qutebrowser.py'))

# # load jblock plugin
# sys.path.append(os.path.join(sys.path[0], 'plugin/jblock'))
# config.source('plugin/jblock/jblock/integrations/qutebrowser.py')
