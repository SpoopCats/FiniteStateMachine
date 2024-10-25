extends CharacterBody2D

var speed = 1400
var dir: Vector2
var player_velocity = dir * speed
var dir_switch = false
var collision_info: KinematicCollision2D

# IT STILL MOVES IN THE MIDDLE, IS THIS WHERE YOU NEED A SEPERATE STATE?
# USE THE COLLIDER NAME TO TRIGGER THE WAITING STATES?
# DOES IT NEED TO HAVE AN INITIAL START PHASE? OR I GUESS IT'S INITIAL START PHASE
# IS WAIT BOTTOM?

func _ready() -> void:
	pass # Replace with function body.


# Called every frame.
func _process(delta: float) -> void:
	check_for_input()
	change_velocity()

# Called every frame.
func _physics_process(delta: float) -> void:
	collision_info = move_and_collide(player_velocity * delta)
	if collision_info:
		return # get rid of this return later!!!
		#print(collision_info.get_collider().get('name'))
	else:
		return
	

func check_for_input():
	if (Input.is_action_just_pressed("ui_accept") == true) and (dir_switch == true): # this can be pressed any time, hence a statemachine is needed
		dir_switch = false
		#print(dir_switch)
		return
	if (Input.is_action_just_pressed("ui_accept") == true) and (dir_switch == false):
		dir_switch = true
		#print(dir_switch)
	else:
		return

func change_velocity():
	if dir_switch == true:
		dir = Vector2.UP
		player_velocity = dir * speed
		#print(dir)
		#print(round(position))
	if dir_switch == false:
		dir = Vector2.DOWN
		player_velocity = dir * speed
		#print(dir)
		#print(round(position))
