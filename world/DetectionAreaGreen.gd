extends Area2D


func _on_DetectionAreaGreen_body_entered(_body):
	EventAggregator.shout("green_entered", [])


func _on_DetectionAreaGreen_body_exited(_body):
	EventAggregator.shout("green_exited", [])
