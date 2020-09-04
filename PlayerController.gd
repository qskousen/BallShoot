extends Node

var velocity = Vector2()

export var gravity = 200.0
export var speed = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):


	if Input.is_action_pressed("fire"):
		var mouse_position = get_viewport().get_mouse_position()
		$Player.fire(mouse_position, self.position)


func _input(event):
	if event is InputEventMouseMotion:
		var mouse_position = event.position
		$Player.set_turret_position(mouse_position, self.position)
		

func _physics_process(delta):
	velocity.y += delta * gravity
	
	if Input.is_action_pressed("discreet_move_left"):
		velocity.x = -speed
	elif Input.is_action_pressed("discreet_move_right"):
		velocity.x = speed
	else:
		velocity.x = 0
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	velocity = $Player.move(velocity)
