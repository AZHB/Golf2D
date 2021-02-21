extends Node

##Scene References##
var player
var level_man

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("Player")
	level_man = get_parent().get_node("LevelManager")

#Passess work to level manager, will return true if player has a shot left.
func shot_taken():
	if level_man.shot_taken():
		return true
	else:
		return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
