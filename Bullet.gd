extends RigidBody2D

signal BulletExpired

func _physics_process(delta):
	position += linear_velocity *  delta


func _on_Timer_timeout():
	emit_signal("BulletExpired", position)
	self.queue_free()
	
