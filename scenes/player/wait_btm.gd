extends State
class_name WaitBtm


func _process(delta: float) -> void:
	if Input.is_action_just_pressed('ui_accept'):
		Transitioned.emit(self, "movingup")


func enter():
	print("State = WaitBtm")
	pass


func exit():
	pass
