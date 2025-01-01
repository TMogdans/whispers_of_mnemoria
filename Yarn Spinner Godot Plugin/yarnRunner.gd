class_name DialogueRunner

signal dialogue_started
signal dialogue_finished
signal line_started(line)
signal line_finished(line)
signal options_available(options)
signal command_executed(command)

var _parser: YarnParser
var _current_node: YarnNode
var _current_line: int
var _waiting_for_input: bool
var _variables: Dictionary
var _wait_timer: Timer


func _init(yarn_script: String):
    _parser = YarnParser.new(yarn_script)


func _ready():
    _wait_timer = Timer.new()
    _wait_timer.one_shot = true
    add_child(_wait_timer)
    _wait_timer.connect("timeout", self, "_on_wait_timer_timeout")


func start_dialogue(node_name: String) -> int:
    var node = _parser.get_node(node_name)
    if not node:
        return ERR_DOES_NOT_EXIST
    
    _variables = {}
    _current_node = node
        _current_line = 0
        _waiting_for_input = false
    emit_signal("dialogue_started")
    var process_result = _process_next_line()
    if process_result != OK:
        return process_result
    
    return OK


func _process_next_line() -> int:
    if _current_line >= _current_node.body.size():
        if _current_node.loop_count > 1:
            _current_node.loop_count -= 1
        _current_line = 0
    return OK
        elif _current_node.repeating:
        _current_line = 0
    return OK
        else:
            return _check_options()

    var line = _current_node.body[_current_line]
    line = _interpolate_variables(line)
    _current_line += 1
    emit_signal("line_started", line)

    if line.begins_with("<<"):
        var command_result = _execute_command(line)
        if command_result != OK:
            return command_result
    else:
        emit_signal("line_finished", line)
        if _current_node.wait_for_input:
            _waiting_for_input = true
            else:
            if _current_node.wait_time > 0:
                _wait_timer.start(_current_node.wait_time)
        else:
                _wait_timer.start(0.1)  # Default wait time
    return OK


func _check_options() -> int:
    var options = _current_node.options
    var valid_options = []
    
    for option in options:
        var condition = option.get("condition")
        if condition:
        var evaluation_result = _evaluate_condition(condition)
        if evaluation_result is bool:
                if evaluation_result:
                    valid_options.append(option)
        else:
            return evaluation_result
    else:
            valid_options.append(option)
    
    if valid_options.size() > 0:
        emit_signal("options_available", valid_options)
    else:
        emit_signal("dialogue_finished")
    
    return OK


func choose_option(index: int) -> int:
    if index < 0 or index >= _current_node.options.size():
        return ERR_PARAMETER_RANGE_ERROR
    
    var option = _current_node.options[index]
    var destination = option.get("destination")
    
    if destination:
        var next_node = _parser.get_node(destination)
        if not next_node:
            return ERR_DOES_NOT_EXIST
        
        _current_node = next_node
        _current_line = 0
        var process_result = _process_next_line()
        if process_result != OK:
            return process_result
    else:
        emit_signal("dialogue_finished")
    
    return OK


func _execute_command(command: String) -> int:
    if command.begins_with("set"):
        var parts = command.replace("set", "").strip_edges().split("to")
        if parts.size() != 2:
            return ERR_INVALID_DATA
        
        var variable = parts[0].strip_edges()
        var value = parts[1].strip_edges()
        _variables[variable] = value
    elif command.begins_with("if"):
        var condition = command.replace("if", "").strip_edges()
        var evaluation_result = _evaluate_condition(condition)
        if evaluation_result is bool:
            if not evaluation_result:
                var process_result = _process_next_line()
                if process_result != OK:
                    return process_result
        else:
            return evaluation_result
    elif command.begins_with("branch"):
        var branch_destination = command.replace("branch", "").strip_edges()
        var next_node = _parser.get_node(branch_destination)
        if not next_node:
            return ERR_DOES_NOT_EXIST
        
        _current_node = next_node
        _current_line = 0
        var process_result = _process_next_line()
        if process_result != OK:
            return process_result
    elif command.begins_with("join"):
        var join_destination = command.replace("join", "").strip_edges()
        var next_node = _parser.get_node(join_destination)
        if not next_node:
            return ERR_DOES_NOT_EXIST
    
        _current_node = next_node
        _current_line = 0
        var process_result = _process_next_line()
        if process_result != OK:
            return process_result
    elif command.begins_with("loop"):
        var loop_count = command.replace("loop", "").strip_edges().to_int()
        if loop_count <= 0:
            return ERR_INVALID_DATA
        _current_node.loop_count = loop_count
    elif command.begins_with("repeat"):
        _current_node.repeating = true
    elif command.begins_with("waitfor"):
        var wait_for = command.replace("waitfor", "").strip_edges()
        if wait_for == "input":
            _current_node.wait_for_input = true
        elif wait_for == "timer":
            _current_node.wait_for_input = false
        else:
            return ERR_INVALID_DATA
    else:
        emit_signal("command_executed", command)
    
    if not command.begins_with("if") and not command.begins_with("branch") and not command.begins_with("join"):
        var process_result = _process_next_line()
        if process_result != OK:
            return process_result
    
    return OK


func _evaluate_condition(condition: String):
    var parts = condition.split(" ")
    if parts.size() != 3:
        return ERR_INVALID_DATA
    
    var left = parts[0].strip_edges()
    var operator = parts[1].strip_edges()
    var right = parts[2].strip_edges()
    
    if left in _variables:
        left = _variables[left]
    if right in _variables:
        right = _variables[right]
    
    match operator:
        "==":
            return left == right
        "!=":
            return left != right
        ">":
            if not (left.is_valid_float() and right.is_valid_float()):
                return ERR_INVALID_DATA
            return float(left) > float(right)
        "<":
            if not (left.is_valid_float() and right.is_valid_float()):
                return ERR_INVALID_DATA
            return float(left) < float(right)
        ">=":
            if not (left.is_valid_float() and right.is_valid_float()):
                return ERR_INVALID_DATA
            return float(left) >= float(right)
        "<=":
            if not (left.is_valid_float() and right.is_valid_float()):
                return ERR_INVALID_DATA
            return float(left) <= float(right)
        _:
            return ERR_INVALID_DATA


func _on_wait_timer_timeout():
    if _waiting_for_input:
        _waiting_for_input = false
        var process_result = _process_next_line()
        if process_result != OK:
            pass


func _interpolate_variables(line: String) -> String:
    var regex = RegEx.new()
    regex.compile("\\$\\{(\\w+)\\}")
    var result = regex.search_all(line)
    
    for r in result:
        var variable_name = r.get_string(1)
        if _variables.has(variable_name):
            var variable_value = _variables[variable_name]
            line = line.replace(r.get_string(0), str(variable_value))
    
    return line