extends Node
class_name State

# any time we want to leave a state we will call this signal
signal Transitioned

func Enter():
	pass


func Exit():
	pass


func Update(_delta: float):
	pass


func Physics_Update(_delta: float):
	pass
