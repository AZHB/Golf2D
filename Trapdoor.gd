extends StaticBody2D

#Public variables
export(bool) var automatic = false

#Internal variables
var activated = false setget activated_set

func visuals(b_closed):
	if b_closed:
		$TrapdoorHingeL.rotation_degrees = 0
		$TrapdoorHingeR.rotation_degrees = 0
	else:
		$TrapdoorHingeL.rotation_degrees = 90
		$TrapdoorHingeR.rotation_degrees = -90

#VERY IMPORTANT - setting activated here does not call activated_set() since it is within class
#If this was not the case, we would be stuck in a recursive loop as we set activated inside func
func activated_set(p_activated):
	activated = p_activated #gonna need to do a lot more than this for this scene to be honest
	if activated:
		$TrapdoorCollision.set_deferred("disabled", true)
		visuals(false)
	else:
		$TrapdoorCollision.set_deferred("disabled", false)
		visuals(true)

# Called when the node enters the scene tree for the first time.
func _ready():
	if automatic:
		activated_set(true)
	else:
		activated_set(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
