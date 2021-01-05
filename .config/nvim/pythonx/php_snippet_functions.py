def find_file(name, path):
    import os
    dir = os.path.join(os.getcwd(), os.path.dirname(path))
    rel_dir = ''
    while dir != '/':
        file = os.path.join(dir, name)
        if os.path.isfile(file):
            return (file, rel_dir)
        rel_dir = os.path.join(os.path.basename(dir), rel_dir)
        dir = os.path.dirname(dir)
    return (None, None)


def composer_namespace(path):
    import json
    composer_file_path, rel_dir = find_file('composer.json', path)
    if composer_file_path:
        with open(composer_file_path) as composer_file:
            json_data = json.load(composer_file)
            if 'autoload' in json_data and 'psr-4' in json_data['autoload']:
                for k, v in json_data['autoload']['psr-4'].items():
                    if rel_dir.startswith(v):
                        return k + rel_dir[len(v):].replace('/', '\\').strip('\\')


def composer_name(path):
    import json
    composer_file_path, rel_dir = find_file('composer.json', path)
    if composer_file_path:
        with open(composer_file_path) as composer_file:
            json_data = json.load(composer_file)
            if 'name' in json_data:
                return json_data['name']


def namespace(path):
    ns = composer_namespace(path)
    if ns:
        return 'namespace %s;\n' % ns
    return ''


def parse_property_definition(line):
    import re
    def split(var):
        t, n = var.strip().split()
        if t[0] == '?':
            t = t[1:]
            o = True
        else:
            o = False
        tm, tr = (t.strip().split('|', 1) + [None])[:2]
        tm = re.split('<|\[', tm)[0]
        return (t, tm, tr, n, o)
    vars = line.split(';')
    vars = map(split, vars)
    return list(vars)


#
# Property and method generation
#

def property(snip, type, name, optional):
    nullable = '|null' if optional else ''
    snip += '/**'
    snip += ' * @var {}{}'.format(type, nullable)
    snip += ' */'
    snip += 'protected $%s;' % name


def getter(snip, type, type_main, name, optional):
    nullable = '?' if optional else ''
    snip += '/**'
    snip += ' * @return {}'.format(type)
    snip += ' */'
    snip += 'public function get{}(): {}{}'.format(upperfirst(name), nullable, type_main)
    snip += '{'
    snip += '\treturn $this->{};'.format(name)
    snip += '}'


def setter(snip, type, type_main, name, optional):
    nullable = '?' if optional else ''
    snip += '/**'
    snip += ' * @param {} ${}'.format(type, name)
    snip += ' * @return void'
    snip += ' */'
    snip += 'public function set{}({}{} ${}): void'.format(
        upperfirst(name), nullable, type_main, name)
    snip += '{'
    snip += '\t$this->{} = ${};'.format(name, name)
    snip += '}'

def upperfirst(x):
    return x[:1].upper() + x[1:]

#
# docblock generation
#

def docblock_method(snip, desc, args, ret):
    def format_arg(arg):
        return ' * @param ' + arg
    args = [arg.strip() for arg in args.split(',') if arg]
    snip.rv = '/**'
    snip += ' * ' + desc
    snip += ' *'
    if len(args):
        tags = map(format_arg, args)
        for tag in tags:
            snip += tag
    snip += ' * @return ' + ret
    snip += ' */'
