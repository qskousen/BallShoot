extends CanvasLayer

var blue_score = 0

var green_score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	EventAggregator.listen("blue_entered", funcref(self, "_on_DetectionArea_blue_body_entered"))
	EventAggregator.listen("blue_exited", funcref(self, "_on_DetectionArea_blue_body_exited"))
	EventAggregator.listen("green_entered", funcref(self, "_on_DetectionArea_green_body_entered"))
	EventAggregator.listen("green_exited", funcref(self, "_on_DetectionArea_green_body_exited"))


func update_blue_score(score):
	blue_score += score
	$BlueScore.text = str(blue_score)
	
	
func update_green_score(score):
	green_score += score
	$GreenScore.text = str(green_score)


func _on_DetectionArea_blue_body_entered():
	$BlueScoreTimer.start()


func _on_DetectionArea_blue_body_exited():
	$BlueScoreTimer.stop()


func _on_DetectionArea_green_body_entered():
	$GreenScoreTimer.start();


func _on_DetectionArea_green_body_exited():
	$GreenScoreTimer.stop()


func _on_BlueScoreTimer_timeout():
	update_green_score(1)


func _on_GreenScoreTimer_timeout():
	update_blue_score(1)


func _on_GetReadyTimer_timeout():
	$Message.visible = false
