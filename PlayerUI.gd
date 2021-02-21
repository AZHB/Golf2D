extends Control

#Internal variables
var shots_counter
var time_counter
var b_counting = false

func update_shots(shots_left):
	#shots_counter.text = str(shots_left)
	pass

#func update_time(time_left):
#	time_counter.text = str(time_left)

func modify_time(time_left):
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	shots_counter = $CenterContainer/HBoxContainer/ShotsPanel/MarginContainer/VBoxContainer2/ShotsCounter
	#time_counter = $CenterContainer/HBoxContainer/TimePanel/VBoxContainer2/CenterContainer/TimeCounter

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	get_tree().reload_current_scene()
