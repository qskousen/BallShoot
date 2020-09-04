extends Node

var starting_position = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	starting_position = self.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("fire"):
		var mouse_position = get_viewport().get_mouse_position()
		$Tank.fire(mouse_position, starting_position)

	if Input.is_action_pressed("discreet_move_left"):
		$Tank.move("left", delta)
	elif Input.is_action_pressed("discreet_move_right"):
		$Tank.move("right", delta)
	else:
		$Tank.move("none", delta)


func _input(event):
	if event is InputEventMouseMotion:
		var mouse_position = event.position
		$Tank.set_turret_position(mouse_position, starting_position)
