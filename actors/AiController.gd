extends Node2D


var starting_position = Vector2()

var ramming_distance = 150

var aim_high = 300

var target = null

var view_port_width = 0
var view_port_width_half = 0
var view_port_width_three_quarters = 0
var view_port_width_five_sixth = 0
var view_port_height = 0
var tank_position = Vector2()

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	starting_position = self.position
	
	view_port_height = get_viewport().size.y

	view_port_width = get_viewport().size.x
	view_port_width_half = view_port_width / 2
	view_port_width_five_sixth = (view_port_width / 6) * 5
	view_port_width_three_quarters = view_port_width_half + view_port_width / 4
	
	
func _physics_process(delta):	
	if not target:
		return
		
	tank_position = $Tank.position + starting_position
	
	if Globals.ai_difficulty == Globals.AiDifficulty.EASY:
		_easy_ai(delta)
	elif Globals.ai_difficulty == Globals.AiDifficulty.MODERATE:
		_moderate_ai(delta)
	elif Globals.ai_difficulty == Globals.AiDifficulty.HARD:
		_hard_ai(delta)
		
			
func _easy_ai(delta):
	if target.position.x < view_port_width_half:
		$Tank.move("right", delta)
	elif ramming_distance > abs(target.position.y - tank_position.y): # Run into the ball
		if tank_position.x > target.position.x:
			$Tank.move("left", delta)
		else:
			$Tank.move("right", delta)
	elif target.position.x > view_port_width_half and target.position.x < view_port_width_three_quarters:
		$Tank.move("right", delta)
	else:
		$Tank.move("none", delta)

	if $Tank.is_gun_ready_to_shoot:
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(tank_position, target.position, [self], 0b100)
		if result and result.collider == target:
			rng.randomize()
			var aim_error_x = rng.randi_range(-100, 100)
			var aim_error_y = rng.randi_range(-100, 100)
			var aim_error = Vector2(aim_error_x, aim_error_y)
			$Tank.fire(target.position + aim_error, starting_position)
			
	
func _moderate_ai(delta):
	if target.position.x < view_port_width_half:
		$Tank.move("right", delta)
	elif ramming_distance > abs(target.position.y - tank_position.y): # Run into the ball
		if tank_position.x > target.position.x:
			$Tank.move("left", delta)
		else:
			$Tank.move("right", delta)
	elif target.position.x > view_port_width_half and target.position.x < view_port_width_three_quarters:
		$Tank.move("right", delta)
	else:
		$Tank.move("none", delta)

	if $Tank.is_gun_ready_to_shoot:
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(tank_position, target.position, [self], 0b100)
		if result and result.collider == target:
			var shoot_at_position = target.position
			$Tank.fire(target.position, starting_position)


func _hard_ai(delta):	
	# In other players side
	if target.position.x < view_port_width_half:
		$Tank.move("right", delta)
	elif ramming_distance > abs(target.position.y - tank_position.y): # Run into the ball
		if tank_position.x > target.position.x:
			$Tank.move("left", delta)
		else:
			$Tank.move("right", delta)
	elif target.position.x > view_port_width_half and target.position.x < view_port_width_five_sixth:
		$Tank.move("right", delta)
	elif target.position.x > view_port_width_five_sixth:
		$Tank.move("left", delta)
	else:
		$Tank.move("none", delta)
		
	if $Tank.is_gun_ready_to_shoot:
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(tank_position, target.position, [self], 0b100)
		if result and result.collider == target:
			var shoot_at_position = _aim_at_target(target)
			$Tank.fire(shoot_at_position, starting_position)
		else:
			var new_target = Vector2(view_port_width_half, view_port_height / 2 - aim_high)
			$Tank.fire(new_target, starting_position)
			

func _aim_at_target(target):
	var bullet_initial_position = $Tank.get_starting_bullet_position(starting_position)
	
	var distance_target_bullet = bullet_initial_position - target.position
	var distToTargetSqr = distance_target_bullet.length_squared()
	var distToTarget = distance_target_bullet.length()
	var targetToBulletNorm = distance_target_bullet / distToTarget
	var tarSpeed = target.linear_velocity.length()
	var tarSpeedSqr = target.linear_velocity.length_squared()
	var tarVelNorm = target.linear_velocity / tarSpeed
	var projSpeedSqr = Globals.bullet_speed * Globals.bullet_speed
	var cosTheta = Vector2(targetToBulletNorm).dot(tarVelNorm)
	
	var offsetSqrPart = 2 * distToTarget * tarSpeed * cosTheta
	offsetSqrPart *= offsetSqrPart
	var offset = sqrt(offsetSqrPart + 4 * (projSpeedSqr - tarSpeedSqr) * distToTargetSqr)
	
	var estimatedTravelTime = (-2 * distToTarget * tarSpeed * cosTheta + offset) / (2 * (projSpeedSqr - tarSpeedSqr))
	if(estimatedTravelTime <= 0 or is_nan(estimatedTravelTime)):
		return target.position
	else:
		var anticipated_aim = target.position + tarVelNorm * tarSpeed * estimatedTravelTime
		return anticipated_aim
	
