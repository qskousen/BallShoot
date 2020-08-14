extends KinematicBody2D

export var speed = 400
export var gravity = 200.0

signal shoot(Bullet, direction, location)

var Bullet = preload("res://Bullet.tscn")

var velocity = Vector2()

var turret_flipped_position = 16

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


func _input(event):
	var tank_position = position + $Turret.position
	var mouse_position
	
	if event is InputEventMouseMotion:
		mouse_position = event.position
		set_turret_position(mouse_position, tank_position)


	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			set_turret_position(event.position, tank_position)
			var turret_size = $Turret.texture.get_height()
			var offset_position = Vector2(-turret_size,0) # include the gun length in the bullet_starting_position
			var offset_rotated = offset_position.rotated(deg2rad($Turret.rotation_degrees + 90))
			var bullet_starting_position = tank_position + offset_rotated

			emit_signal("shoot", Bullet, deg2rad($Turret.rotation_degrees + 90), bullet_starting_position)


func _physics_process(delta):
	velocity.y += delta * gravity
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x = speed
	else:
		velocity.x = 0
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	move_and_slide(velocity, Vector2(0, -1))


func set_turret_position(mouse_position, tank_position):
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
	
