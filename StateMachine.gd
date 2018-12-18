extends Node

var states_stack = []
var states_map = {}
var state = null

var initialized = false

onready var host = get_owner()

func _ready():
	# Must be called with array of states before anything.
	# The first state in the array is the starting state for the machine.
	var states_array = get_children()
	var state_name
	for new_state in states_array:
		state_name = format_state_name(new_state.name)
		states_map[state_name] = new_state
	_change_state(format_state_name(states_array[0]))

func _process(delta):
	var next_state_name = state.process(delta)
	if next_state_name:
		_change_state(next_state_name)

func _change_state(state_name):
	# Sets current state value to input, exits & cleans up previous state, and enters new one.
	var next_state

	# Special case if keyword "previous" is passed. State machine returns to previous state.
	if state_name == "previous":
		states_stack.pop_front()
		next_state = states_stack[0]
	else:
		next_state = states_map[state_name]

	state.exit()
	state = next_state
	state.name = format_state_name(state.name)
	states_stack.push_front(state)
	state.enter()
	emit_signal("state_changed", states_stack)


func format_state_name(unformatted_state):
	# Formats state names to camelCase.
	var iter = 0
	var name_ = unformatted_state.name
	name_[0] = name_[0].to_lower()
	return(str(name_))