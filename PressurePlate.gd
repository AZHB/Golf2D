extends StaticBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#Public variables
export(Array, NodePath) var interactable_paths

#Internal variables
var b_flipped = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func visual_pressed():
	$Plate.position.y = -26
	
func visual_unpressed():
	$Plate.position.y = -34

func _on_Area2D_body_entered(body):
	if !b_flipped:
		b_flipped = true
		for node_path in interactable_paths:
			var node = get_node(node_path)
			node.activated = true
		visual_pressed()

func _on_Area2D_body_exited(body):
	$Plate.position.y = -26
	for node_path in interactable_paths:
		var node = get_node(node_path)
		node.activated = false
	visual_unpressed()
	b_flipped = false
