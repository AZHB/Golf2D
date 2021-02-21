extends KinematicBody2D

#external variables
export(bool) var automatic = true
export(bool) var clockwise = true
export(int) var speed_deg = 10 #degrees per second

#internal variables
var activated = false setget activated_set
var clockwise_int

func activated_set(p_activated):
	activated = p_activated

func _physics_process(delta):
	if activated:
		rotation_degrees += speed_deg * delta * clockwise_int

# Called when the node enters the scene tree for the first time.
func _ready():
	if clockwise:
		clockwise_int = 1
	else:
		clockwise_int = -1
	if automatic:
		activated = true
	else:
		activated = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
