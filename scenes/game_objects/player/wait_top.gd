extends State
class_name WaitTop

@onready var scene_change_timer: Timer = $"../../SceneChangeTimer"
@onready var top_sfx: AudioStreamPlayer2D = $"../../TopSfx"
@onready var player: CharacterBody2D = $"../.."
@onready var moving_up: MovingUp = $"../MovingUp"
@onready var moving_down: MovingDown = $"../MovingDown"
@export var times_up_msg_instance: PackedScene


func Enter():
	top_sfx.play()
	# emit signal to instantiate food on btm pedestal
	GameEvents.emit_spawn_food_btm()
	GameEvents.time_expired_game_over.connect(_on_time_expired_game_over)


func Update(delta: float):
	if Input.is_action_just_pressed('ui_accept'):
		Transitioned.emit(self, "movingdown")

func Physics_Update(delta: float):
	pass


func _on_time_expired_game_over():
	game_over_tween()


func game_over_tween():
	# stop player from moving
	moving_down.player_velocity = Vector2.ZERO
	moving_up.player_velocity = Vector2.ZERO
	# tween player object
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(player, 'scale', Vector2(0, 0), 0.35)
	tween.tween_property(player, 'rotation', 6.283185, 0.25)
	await  tween.finished
	player.hide()
	# instantiate game over msg
	var  times_up_msg_instance = times_up_msg_instance.instantiate()
	times_up_msg_instance.position = Vector2(640 / 2, 360 / 2)
	# really sloppy way of referencing the main game scene!
	get_parent().get_parent().get_parent().add_child(times_up_msg_instance)
	scene_change_timer.start()


func Exit():
	pass
