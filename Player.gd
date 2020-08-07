extends KinematicBody2D

export var speed = 400
export var gravity = 200.0

var velocity = Vector2()

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


func _input(event):
	var tank_position = self.position
	var mouse_position
	
	if event is InputEventMouseMotion:
		mouse_position = event.position
		var x = tank_position.x - mouse_position.x
		var y = tank_position.y - mouse_position.y
		var angle_between_points = rad2deg(atan2(y, x))
		print(angle_between_points)
		
		$Tank.flip_h = 0 < angle_between_points and angle_between_points < 90
	
		if $Tank.flip_h:
			$Turret.position.x = -16
			if $Turret.rotation_degrees > 0:
				$Turret.rotation_degrees *= -1
			var max_angle = 0
			var min_angle = -90
			var adjusted_angle = min_angle + angle_between_points
			print(adjusted_angle)
			adjusted_angle = clamp(adjusted_angle, min_angle, max_angle)
			print(adjusted_angle)
			if adjusted_angle > min_angle and adjusted_angle < max_angle:
				$Turret.rotation_degrees = adjusted_angle
		else:
			$Turret.position.x = 16
			if $Turret.rotation_degrees < 0:
				$Turret.rotation_degrees *= -1
			var adjusted_angle = angle_between_points - 90
			adjusted_angle = clamp(adjusted_angle, 0, 90)
			if adjusted_angle > 0 and adjusted_angle < 90:
				$Turret.rotation_degrees = adjusted_angle



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
