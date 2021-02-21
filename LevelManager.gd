extends Node

##Scene References##
var interactables
var ruleset
var player_ui

##Internal variables##
var shots_left
var time_left
var timer

# Called when the node enters the scene tree for the first time.
func _ready():
	interactables = get_parent().get_node("Interactables")
	ruleset = get_node("Ruleset")
	player_ui = get_parent().get_node("UI/PlayerUI")
	timer = $Timer
	shots_left = ruleset.num_shots
	time_left = ruleset.time_limit
	if shots_left != INF:
		player_ui.update_shots(shots_left)
	#if time_left != INF:
	#	timer.start(1)

#called by player manager
func shot_taken():
	shots_left -= 1
	player_ui.update_shots(shots_left)
	if shots_left > 0:
		return true
	else:
		return false

func _on_Timer_timeout():
	time_left -= 1
	player_ui.update_time(time_left)
	#DO SOMETHING IF TIME RUNS OUT
