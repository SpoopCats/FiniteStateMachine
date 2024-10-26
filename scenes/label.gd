extends Label

@onready var player = $"../Player"
@onready var label: Label = $"."
var score = 0


func _ready() -> void:
#works, still sloppy and dependent on things not being moved
#honestly... it's not as sloppy as I thought at first glance
# I'm unlikely to move the state machine around in the tree at all

# check if player exists
	if player:
		#get the MovingDown node from the FSM
		var moving_down_node = player.get_node("../Player/StateMachine/MovingDown")
		#connect the custom signal from MovingDown node
		moving_down_node.score_signal.connect(_on_score_signal)


func _on_score_signal():
	score += 1
	label.text = str(score)
