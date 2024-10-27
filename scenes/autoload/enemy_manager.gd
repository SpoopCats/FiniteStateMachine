extends Node

# could this be an array of packed scenes that can be chosen from?
# with all cat parameters set?
# is that easier?
# then we can just handle the logic of instantiating X enemy type 
# that is already chosen?
# here is documentation on it
# https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_exports.html#exporting-arrays

# I could randomize textures with different behaviours possibly...
# this could be confusing to the player though if they look different but
# act the same as others.
# perhaps variations could exist like color?
# could be getting too fancy too early with the enemy_texture export

@export var enemy_textures: Array[Texture] = []
@export var enemy_scenes: Array[PackedScene] = []

# maybe a dictionary with lane 1: [left_pos, right_pos] and drop key 1
# then add it back in after lane is clear and enemy queue_frees?
var spawn_points = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
