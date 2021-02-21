extends StaticBody2D

#public variables
export(int) var field_height = 80 #make sure to half this for shape extents
export(int) var push_power = 20 #Push power, make sure to invert for shape gravity vector
export(bool) var automatic = true

#internal variables
var field_area
var field_shape
var sprite
var activated = false setget activated_set

func activated_set(p_activated):
	activated = p_activated
	if activated:
		field_area.space_override = field_area.SPACE_OVERRIDE_COMBINE
	if !activated:
		field_area.space_override = field_area.SPACE_OVERRIDE_DISABLED

# Called when the node enters the scene tree for the first time.
func _ready():
	field_area = $Field
	field_shape = $Field/CollisionShape2D
	sprite = $Sprite
	
	#Position the field shape correctly
	var required_length = (sprite.texture.get_height()*sprite.scale.y/2) + field_height/2
	field_shape.position = Vector2(0,-required_length)
	field_shape.shape.extents = Vector2(sprite.texture.get_width()*sprite.scale.x/2,field_height/2)
	field_area.gravity_vec = -transform.y*(push_power)
	
	#Activate
	if (automatic):
		activated_set(true)
	else:
		activated_set(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
