extends Node2D

#external variables
export(int) var speed = 1
export(int) var wait_time = 3
export(bool) var automatic = true

#internal varaibles
var coll_shape
var wait_timer
var mid_sprite_tex
var move_vec
var current_dist
var b_moving = false
var activated = false setget activated_set
var b_waiting = false

func activated_set(p_activated):
	activated=p_activated

func _physics_process(delta):
	if activated and !b_waiting:
		if current_dist == 0:
			move_vec = -move_vec
			current_dist = move_vec.length()
			wait_timer.start()
			b_waiting = true
		else:
			$MovingPlatform.position += move_vec.clamped(min(speed,current_dist))
			current_dist -= min(speed,current_dist)

# Called when the node enters the scene tree for the first time.
func _ready():
	wait_timer = $Timer
	wait_timer.wait_time = wait_time
	coll_shape = $MovingPlatform/CollisionShape2D
	mid_sprite_tex = preload("res://Scenes/LevelDesign/Prefabs/MovingPlatform/platformMid.png")
	if automatic:
		activated = true
	else:
		activated = false
	move_vec = $PlatformEnd.position - $MovingPlatform.position
	current_dist = move_vec.length()
	
	#Set physics material through code
	Physics2DServer.body_set_param($MovingPlatform.get_rid(), Physics2DServer.BODY_PARAM_BOUNCE, 0)
	Physics2DServer.body_set_param($MovingPlatform.get_rid(), Physics2DServer.BODY_PARAM_FRICTION, 1)
	

func _on_Timer_timeout():
	b_waiting = false
	$MovingPlatform.position += move_vec.clamped(min(speed,current_dist))
	current_dist -= min(speed,current_dist)
