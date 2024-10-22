extends Node

@export var initial_state: State
var current_state: State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			# any time we register a new state, we connect the Transitioned signal
			child.Transitioned.connect(on_child_transition)
	# set our exported variable initial state to the current state
	if initial_state:
		initial_state.Enter()
		current_state = initial_state


func _process(delta):
	if current_state:
		current_state.Update(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_Update(delta)

# takes in state that called it and the new state that it wants to move to
func on_child_transition(state, new_state_name):
	# ensure the state calling this is not already the current state
	if state != current_state:
		return
	# grab the new state from the 'states' dictionary and make sure it exists
	var new_state = states.get(new_state_name.to_lower())
	# make sure the new state exists, I believe this is handling null?
	if !new_state:
		return
	# if the current state does exist, we will call exit()
	if current_state:
		current_state.exit()
	# call the enter function on the new state
	new_state.enter()
	# set the current state to the new state
	current_state = new_state
