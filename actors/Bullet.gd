extends RigidBody2D

func _ready():
	linear_velocity = Vector2(-Globals.bullet_speed * 10, 0)
	$Timer.start(Globals.bullet_life)

func _physics_process(delta):
	position += linear_velocity * delta


func _on_Timer_timeout():
	EventAggregator.shout("bullet_expired", [position])
	self.queue_free()
	
