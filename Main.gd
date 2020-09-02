extends Node

var TurretSpray = preload("res://ShotFiredParticles.tscn")
var BulletBreak = preload("res://ShotBreakingParticles.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Player_shoot(Bullet, direction, location):
	var b = Bullet.instance()
	add_child(b)
	b.rotation = direction
	b.position = location
	b.linear_velocity = b.linear_velocity.rotated(direction)
	b.connect("BulletExpired", self, "on_bullet_expired")
	var spray = TurretSpray.instance()
	spray.emitting = true
	spray.position = location
	spray.rotation = direction + PI
	add_child(spray)
	
func on_bullet_expired(position):
	var rubble = BulletBreak.instance()
	rubble.emitting = true
	rubble.position = position
	add_child(rubble)
