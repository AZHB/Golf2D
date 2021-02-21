extends StaticBody2D

# Declare member variables here. Examples:
#-16 is where the button should be positioned afterwards and -24 is where it starts

#Public variables
export(Array, NodePath) var interactable_paths

#Internal variables
var b_flipped


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func visual_pressed():
	$Button.position.y = -16

func _on_ButtonArea_body_entered(body):
	if !b_flipped:
		b_flipped = true
		for node_path in interactable_paths:
			var node = get_node(node_path)
			node.activated = true
		visual_pressed()
