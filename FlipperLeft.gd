extends Node2D

#public variables
export(float) var rest_time = 0.4
export(float) var flip_time = 0.08
export(float) var flip_hold_time = 0.4
export(bool) var automatic = true
export(bool) var oneshot = false

#internal variables
var rest_timer
var anim_player
var activated = false setget activated_set

func activated_set(p_activated):
	activated = p_activated
	if activated:
		anim_player.play(name)

# Called when the node enters the scene tree for the first time.
func _ready():
	#Get references
	anim_player = $Flipper/AnimationPlayer
	rest_timer = $Flipper/AnimationPlayer/Timer
	
	#Set user-defined editor properties for flip animation
	#var flip_anim = anim_player.get_animation("Flip")
	var flip_anim = preload("res://Scenes/LevelDesign/Prefabs/Flipper/flip.tres").duplicate()
	flip_anim.add_track(flip_anim.TYPE_VALUE,0) #FINISH
	flip_anim.track_set_path(0,"../Flipper:rotation_degrees")
	flip_anim.track_insert_key(0,0,0,1)
	flip_anim.track_insert_key(0,flip_time,45,1)
	flip_anim.track_insert_key(0,flip_time+flip_hold_time,45,1)
	flip_anim.track_insert_key(0,flip_time+flip_time+flip_hold_time,0,1)
	flip_anim.set_length(flip_time+flip_time+flip_hold_time)
	anim_player.add_animation(name,flip_anim)
	
	#set user-defined editor properties for timer
	rest_timer.wait_time = rest_time
	
	#Start flipper
	if(automatic):
		activated_set(true)
	else:
		activated_set(false)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if activated and !oneshot:
		rest_timer.start()
	if oneshot:
		activated = false

func _on_Timer_timeout():
	anim_player.play(name)
