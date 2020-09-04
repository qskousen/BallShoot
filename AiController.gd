extends Node2D


var starting_position = Vector2()

var ramming_distance = 150

var aim_high = 300

var target = null

var view_port_width = 0
var view_port_width_half = 0
var view_port_width_three_quarters = 0
var view_port_height = 0
var tank_position = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	starting_position = self.position
	
	view_port_height = get_viewport().size.y

	view_port_width = get_viewport().size.x
	view_port_width_half = view_port_width / 2
	view_port_width_three_quarters = view_port_width_half + view_port_width / 4
	

func _process(delta):
	if not target:
		return
		
	tank_position = $Tank.position + starting_position
	
	if target.position.x < view_port_width_half:
		$Tank.move("right", delta)
	elif ramming_distance > abs(target.position.y - tank_position.y): # Run into the ball
		if tank_position.x > target.position.x:
			$Tank.move("left", delta)
		else:
			$Tank.move("right", delta)
	elif target.position.x > view_port_width_half and target.position.x < view_port_width_three_quarters:
		$Tank.move("right", delta)
	elif target.position.x > view_port_width_three_quarters:
		$Tank.move("left", delta)
	else:
		$Tank.move("none", delta)
	
	
func _physics_process(_delta):	
	if target and $Tank.is_gun_ready_to_shoot:
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(tank_position, target.position, [self], 0b100)
		if result and result.collider == target:
			$Tank.fire(target.position, starting_position)
		else:
			var new_target = Vector2(view_port_width_half, view_port_height / 2 - aim_high)
			$Tank.fire(new_target, starting_position)
