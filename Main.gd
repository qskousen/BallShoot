extends Node

var BulletSpray = preload("res://ShotFiredParticles.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Player_shoot(Bullet, direction, location):
	var b = Bullet.instance()
	add_child(b)
	b.rotation = direction
	b.position = location
	b.linear_velocity = b.linear_velocity.rotated(direction)
	var spray = BulletSpray.instance()
	spray.emitting = true
	add_child(spray)
	spray.position = location
	spray.rotation = direction + PI
#	
