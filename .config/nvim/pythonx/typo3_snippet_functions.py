from php_snippet_functions import *


def typo3_extension_name(path):
    name = composer_name(path)
    return name.split('/')[1]
