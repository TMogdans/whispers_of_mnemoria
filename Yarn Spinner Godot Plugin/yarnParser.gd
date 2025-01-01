class_name YarnParser

var _lines: Array
var _nodes: Dictionary
var _current_node: YarnNode
var _current_line: int

func _init(yarn_script: String):
    var parse_result = _parse(yarn_script)
    if parse_result != OK:
        push_error("Fehler beim Parsen des Yarn-Skripts: " + str(parse_result))


func _parse(yarn_script: String) -> int:
    _lines = yarn_script.split("\n")
    _current_line = 0
    
    while _current_line < _lines.size():
        var line = _lines[_current_line].strip_edges()
        
        if line.begins_with("title:"):
            var title_result = _parse_node_title(line)
            if title_result != OK:
                return title_result
        elif line.begins_with("---"):
            var body_result = _parse_node_body()
            if body_result != OK:
                return body_result
        
        _current_line += 1

    return OK


func _parse_node_title(line: String) -> int:
    var title = line.replace("title:", "").strip_edges()
    if title.empty():
        return ERR_INVALID_DATA
    
    _current_node = YarnNode.new(title, [], [], [], {})
    _nodes[title] = _current_node
    return OK


func _parse_node_body() -> int:
    var body = []
    _current_line += 1
    
    while _current_line < _lines.size():
        var line = _lines[_current_line].strip_edges()
        
        if line.begins_with("==="):
            break
        elif line.begins_with("->"):
            var option_result = _parse_node_option(line)
            if option_result != OK:
                return option_result
        elif line.begins_with("<<"):
            var command_result = _parse_node_command(line)
            if command_result != OK:
                return command_result
        else:
            line = _interpolate_variables(line)
            body.append(line)
        
        _current_line += 1
    
    _current_node.body = body
    return OK


func _parse_node_option(line: String) -> int:
func _parse_node_option(line: String, parent_option: Dictionary = {}) -> int:
    var parts = line.replace("->", "").strip_edges().split("|")
    if parts.size() < 1:
        return ERR_INVALID_DATA
    
    var text = parts[0].strip_edges()
    var destination = null
    var condition = null
    
    if parts.size() > 1:
        var option_parts = parts[1].strip_edges().split("]]")
        if option_parts.size() == 2:
            destination = option_parts[1].strip_edges()
            condition = option_parts[0].replace("[[", "").strip_edges()
        else:
            destination = parts[1].strip_edges()
    _current_node.options.append({

    
    var option = {
        "condition": condition,
        "options": []
    }
    
    if parent_option.empty():
        _current_node.options.append(option)
        else:
            return ERR_INVALID_DATA

        parent_option.options.append(option)
    

func _interpolate_variables(line: String) -> String:
    return OK
    regex.compile("\\$\\{(\\w+)\\}")
    var result = regex.search_all(line)
    
    for r in result:
        var variable_name = r.get_string(1)
        if _current_node.variables.has(variable_name):
            var variable_value = _current_node.variables[variable_name]
            line = line.replace(r.get_string(0), str(variable_value))
    
    return line


func get_node(title: String) -> YarnNode:
    if not _nodes.has(title):
        push_error("Knoten nicht gefunden: " + title)
        return null

    return _nodes[title]


func get_nodes() -> Dictionary:
    return _nodes
