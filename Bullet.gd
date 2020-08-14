extends RigidBody2D


func _physics_process(delta):
	position += linear_velocity *  delta


func _on_Timer_timeout():
	self.queue_free()
