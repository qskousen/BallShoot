extends KinematicBody2D


export var gun_timeout = 1.0
export var timeout_divider = 10.0

var turret_flipped_position = 16

var is_gun_ready_to_shoot


func fire(position_to_fire_at, player_position):
	if is_gun_ready_to_shoot:
		is_gun_ready_to_shoot = false
		$GunTimer.start(gun_timeout / timeout_divider)
		set_turret_position(position_to_fire_at, player_position)
		var turret_size = $Turret.texture.get_height()
		var offset_position = Vector2(-turret_size,0) # include the gun length in the bullet_starting_position
		var offset_rotated = offset_position.rotated(deg2rad($Turret.rotation_degrees + 90))
		var bullet_starting_position = player_position + $Turret.position + offset_rotated
		
		EventAggregator.shout("shoot", [deg2rad($Turret.rotation_degrees + 90), bullet_starting_position])


func move(velocity):
	return move_and_slide(velocity, Vector2(0, -1))

func set_turret_position(mouse_position, player_position):
	var tank_position = player_position + $Turret.position
	var x = tank_position.x - mouse_position.x
	var y = tank_position.y - mouse_position.y
	var angle_between_points = rad2deg(atan2(y, x))
	$Tank.flip_h = tank_position.x > mouse_position.x
	
	$Turret.position.x = -turret_flipped_position if $Tank.flip_h else turret_flipped_position
	
	var adjusted_angle = -90 + angle_between_points if $Tank.flip_h else angle_between_points - 90
	var min_angle = -90 if $Tank.flip_h else 0
	var max_angle = 0 if $Tank.flip_h else 90
	adjusted_angle = clamp(adjusted_angle, min_angle, max_angle)
	
	if min_angle < adjusted_angle and adjusted_angle < max_angle:
		$Turret.rotation_degrees = adjusted_angle

	if $Turret.rotation_degrees > max_angle:
		$Turret.rotation_degrees *= -1

	elif  $Turret.rotation_degrees < min_angle:
		$Turret.rotation_degrees *= -1


func _on_Timer_timeout():
	is_gun_ready_to_shoot = true
