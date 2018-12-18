extends Node

# State interface for StateMachine
var host

func _enter_tree():
	host = get_owner().host

func enter():
	# Initialize state 
	pass

func process(delta):
	#  To use with _process(delta)
	pass

func exit():
	#  Cleanup and exit state
	pass