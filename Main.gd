extends Node

var TurretSpray = preload("res://actors/ShotFiredParticles.tscn")
var BulletBreak = preload("res://actors/ShotBreakingParticles.tscn")
var Bullet = preload('res://actors/Bullet.tscn')

# Called when the node enters the scene tree for the first time.
func _ready():
	EventAggregator.listen("bullet_expired", funcref(self, "_on_bullet_expired"))
	EventAggregator.listen("shoot", funcref(self, "_on_player_shoot"))

func _on_player_shoot(direction, location):
	var b = Bullet.instance()
	add_child(b)
	b.rotation = direction
	b.position = location
	b.linear_velocity = b.linear_velocity.rotated(direction)

	var spray = TurretSpray.instance()
	spray.emitting = true
	spray.position = location
	spray.rotation = direction + PI
	add_child(spray)
	
	
func _on_bullet_expired(position):
	var rubble = BulletBreak.instance()
	rubble.emitting = true
	rubble.position = position
	add_child(rubble)
