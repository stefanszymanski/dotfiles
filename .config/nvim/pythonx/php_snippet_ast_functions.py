def buffer_text(snip):
    code = ''
    for n in range(0, len(snip.buffer)):
        if n == snip.line:
            continue
        code += snip.buffer[n] + '\n'
    return code


def create_ast(code):
    import subprocess
    import json
    cmd = '/home/stefan/projects/php_ast_parser/vendor/bin/php-parse'
    res = subprocess.run([cmd, '-P', '-j', '-r', code], stdout=subprocess.PIPE)
    if res.returncode == 0:
        json_data = res.stdout.decode()
    else:
        return None
    data = json.loads(json_data)
    return data


def find_node(ast, line):
    latest = None
    for node in ast:
        startline = node['attributes']['startLine']
        if startline < line:
            latest = node
            continue
        if startline > line:
            break
        if startline == line:
            # latest = node
            return [node]
        break
    if latest:
        next = None
        node_type = latest['nodeType']
        if node_type in ['Stmt_Expression', 'Expr_Assign']:
            next = [latest['expr']]
        elif node_type in ['Expr_Array']:
            next = latest['items']
        elif node_type in ['Expr_ArrayItem'] and latest['value']['nodeType'] in ['Expr_Array']:
            next = latest['value']['items']
            # next = [latest['value']]
            if next:
                rootline = find_node(next, line)
                rootline.append(latest)
                return rootline
            else:
                return []
        else:
            return []


def flatten_rootline(rootline):
    data = []
    # TODO refactor
    for node in rootline:
        node_type = node['nodeType']
        # data.append(node_type)
        if node_type == 'Expr_ArrayItem':
            if node['key'] and 'value' in node['key'].keys():
                name = node['key']['value']
            else:
                name = None
                value_type = node['value']['nodeType']
                if 'value' in node['value'].keys():
                    value = node['value']['value']
                elif value_type == 'Expr_Array':
                    value = []
                    # for item in node['value']['items']:
                    # 	if item['key'] and 'value' in item['key'].keys():
                    # 		item_name = item['key']['value']
                    # 	else:
                    # 		item_name = None
                    # 	item_type = item['value']['nodeType']
                    # 	if 'value' in item['value'].keys():
                    # 		item_value = item['value']['value']
                    # 	else:
                    # 		item_value = None
                    # 	value.append((item_name, item_value, item_type))
                else:
                    value = None
                    data.append((name, value, value_type))
        return data


def create_rootline(snip):
    code = buffer_text(snip)
    ast = create_ast(code)
    rootline = find_node(ast, snip.line)
    frootline = flatten_rootline(rootline)
    return frootline


def get_node_name(snip, path, target):
    rootline = create_rootline(snip)
    rootline.reverse()
    if rootline[:-1][0] != 'Expr_Array':
        rootline.pop()
    for type, name in path:
        rname, rvalue, rtype = rootline.pop()
        if rname != name or rtype != type:
            break
    rname, rvalue, rtype = rootline.pop()
    if rtype == target:
        column_name = rname
    return column_name
