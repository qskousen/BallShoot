extends RigidBody2D


func _physics_process(delta):
	position += linear_velocity *  delta


func _on_Timer_timeout():
	EventAggregator.shout("bullet_expired", [position])
	self.queue_free()
	
