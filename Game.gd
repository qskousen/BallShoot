extends Node

var TurretSpray = preload("res://actors/ShotFiredParticles.tscn")
var BulletBreak = preload("res://actors/ShotBreakingParticles.tscn")
var Bullet = preload('res://actors/Bullet.tscn')


# Called when the node enters the scene tree for the first time.
func _ready():
	EventAggregator.listen("bullet_expired", funcref(self, "_on_bullet_expired"))
	EventAggregator.listen("shoot", funcref(self, "_on_player_shoot"))
	EventAggregator.listen("start_game_message_gone", funcref(self, "_unpause_game"))
	EventAggregator.listen("game_restart", funcref(self, "_restart"))
	
	if Globals.play_type == Globals.TypeOfPlay.SINGLE_PLAYER:
		_load_ai()
		
	get_tree().paused = true
	

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


func _unpause_game():
	get_tree().paused = false
	
	
func _load_ai():
	var ai = Globals.ai.instance()
	ai.target = $Ball
	ai.position = Globals.starting_point_right
	add_child(ai)	
	
	
func _restart():
	get_tree().reload_current_scene()
