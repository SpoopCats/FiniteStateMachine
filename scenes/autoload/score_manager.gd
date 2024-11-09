extends Node

const SCORESAVEFILE = "user://scoresave.txt"
var current_score: int = 0
var high_score: int = 0


func _ready():
	# make sure high score is up to date from savescorefile.txt file
	load_score()

# save function is called in player.tscn statemachine when the player dies
# when moving up and down. If you ever make it possible to die while waiting
# top and bottom, you'll need to call this function there as welL!+
func save_score():
	# open scoresave.txt with read and write access
	var file = FileAccess.open(SCORESAVEFILE, FileAccess.WRITE_READ)
	# store an int up to 4,294,967,296
	file.store_32(current_score)
	# release use of the file in order to avoid "file is in use" errors
	file = null


func load_score():
	# open scoresave.txt with read access
	var file = FileAccess.open(SCORESAVEFILE, FileAccess.READ)
	# ensure the file does exist
	if FileAccess.file_exists(SCORESAVEFILE):
		high_score = file.get_32()
		print("high score = " + str(high_score))
