extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time_step = .05
var total_steps = 80
var points = []
var grav_acc= 1500
var draw_dist_step = 100 #no idea about this

#internal variables
var player
var ghost_ball

func _process(delta):
	global_rotation = 0

func _ready():
	player = get_parent()
	
	#prepare ghost ball:
	ghost_ball = player.get_parent().get_node("GhostBall")
	ghost_ball.position = player.position

func _draw():
	while !points.empty():
		draw_circle(points.pop_front()-global_position,2,Color(0,1,1,1))

func clear_trace():
	points.clear()
	update()

func draw_next(point):
	points.push_back(point)
	update()

func trace_collision(initial_v):
	ghost_ball.position=player.position
	var velocity = initial_v
	var target = global_position 
	var collision_result = Physics2DTestMotionResult.new()
	
	for i in range(total_steps):
		#Work out next velocity vector
		velocity *= 1-(time_step*0.1) #linear damp
		velocity.y +=  grav_acc*time_step
		var delta_pos = velocity*time_step
		
		if ghost_ball.test_motion(delta_pos,true,0.001,collision_result):
			print("Collision at: ", collision_result.collision_point)
			#draw colliding point
			target += collision_result.motion
			draw_next(target)
			#move ghost ball
			ghost_ball.position += collision_result.motion
			ghost_ball.position -= collision_result.motion_remainder
			#change velocity
			#I give up here.
		
		#temp
		target += delta_pos
		ghost_ball.position += delta_pos
		draw_next(target)

func trace(initial_v):
	var velocity = initial_v
	var target = global_position
	
	for i in range(total_steps):
		velocity.y +=  grav_acc*time_step/2
		velocity *= 1-(time_step*0.15) #linear damp
		velocity.y +=  grav_acc*time_step/2
		var delta_pos = velocity*time_step
		target += delta_pos
		draw_next(target)
