extends State
class_name WaitBtm

@onready var btm_sfx: AudioStreamPlayer2D = $"../../BtmSfx"


func Enter():
	# emit signal to instantiate food on top pedestal
	print("WaitBtm")
	btm_sfx.play()
	GameEvents.emit_spawn_food_top()



func Update(delta: float):
	if Input.is_action_just_pressed('ui_accept'):
		Transitioned.emit(self, "movingup")

func Physics_Update(delta: float):
	pass


func Exit():
	pass
