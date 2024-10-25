extends State
class_name WaitBtm


func enter():
	print("State = WaitBtm")
	pass


func Update( delta: float):
	if Input.is_action_just_pressed('ui_accept'):
		Transitioned.emit(self, "movingup")

func Physics_Update(delta: float):
	pass


func exit():
	pass
