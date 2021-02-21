extends RigidBody2D

##Scene References##
var player_man
var shot_tracer
var shot_ui
var friction_timer

##Variables##
var shot_power = 6
var max_impulse = 300
var max_ui_impulse = 100
var artificial_friction = false

##State Tracking##
var tracking = true #Bool to track if shot tracking should happen
var can_shoot = true #Bool to check if player has shots left from player_man
var ready = false #Bool to track if shot can be taken (is player stationary)

func _ready():
	shot_tracer = get_node("ShotTracer")
	friction_timer = get_node("FrictionTimer")
	player_man = get_parent()
	shot_ui = player_man.get_parent().get_node("UI/PlayerShotPower")

# will need to implement a stop timer
func _physics_process(delta):
	if ready:
		return
	elif linear_velocity.length() < 1: #If stopped, set as ready
		ready = true
		tracking=true
		#shot_tracer.trace((get_viewport().get_mouse_position() - position).clamped(max_impulse)*shot_power)
		attempt_trace_update(get_viewport().get_mouse_position())
		artificial_friction = false

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.is_pressed():
				attempt_shot(event.position)
	if event is InputEventMouseMotion:
		attempt_trace_update(event.position)

func attempt_trace_update(pos):
	if tracking:
		shot_ui.set_value((pos - position).clamped(max_impulse).length()/(max_impulse/max_ui_impulse))
		shot_tracer.trace((pos - position).clamped(max_impulse)*shot_power)

func attempt_shot(click_position):
	if ready and can_shoot:
		apply_central_impulse((click_position-position).clamped(max_impulse)*shot_power)
		ready = false
		tracking = false
		shot_tracer.clear_trace()
		friction_timer.start()
		if player_man.shot_taken():
			can_shoot = true
		else:
			can_shoot = false

#Begin applying artificial friction
func _on_FrictionTimer_timeout():
	artificial_friction = true

#Apply artificial friction on contact
func _on_Player_body_entered(body):
	if artificial_friction:
		#apply_central_impulse(-linear_velocity*.1)
		#apply_torque_impulse(-angular_velocity*.1)
		pass

#Apply artificial friction on contact exit
func _on_Player_body_exited(body):
	apply_central_impulse(-linear_velocity*.04)
	apply_torque_impulse(-angular_velocity*.04)
	pass
