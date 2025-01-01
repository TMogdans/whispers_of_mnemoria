class_name YarnNode

var title: String
var body: Array
var tags: Array
var options: Array
var variables: Dictionary
var branches: Array
var joins: Array
var loop_count: int
var repeating: bool
var wait_time: float
var wait_for_input: bool

func _init(title: String, body: Array, tags: Array, options: Array, variables: Dictionary, branches: Array, joins: Array):
    self.title = title
    self.body = body
    self.tags = tags
    self.options = options
    self.variables = variables
    self.branches = branches
    self.joins = joins
    self.loop_count = 1
    self.repeating = false
    self.wait_time = 0.0
    self.wait_for_input = true