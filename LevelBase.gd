extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player_man
var level_man

# Called when the node enters the scene tree for the first time.
func _ready():
	player_man = get_node("PlayerManager")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
