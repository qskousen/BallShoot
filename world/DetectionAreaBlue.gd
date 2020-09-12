extends Area2D


func _on_DetectionAreaBlue_body_entered(_body):
	EventAggregator.shout("blue_entered", [])


func _on_DetectionAreaBlue_body_exited(_body):
	EventAggregator.shout("blue_exited", [])

