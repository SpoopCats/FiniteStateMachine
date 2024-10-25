extends State
class_name WaitTop


func _process(delta: float) -> void:
	if Input.is_action_just_pressed('ui_accept'):
		Transitioned.emit(self, "movingdown")


func enter():
	print("State = WaitTop")
	pass


func exit():
	pass
