extends CanvasLayer

var blue_score = 0

var green_score = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_blue_score(score):
	blue_score += score
	$BlueScore.text = str(blue_score)
	
func update_green_score(score):
	green_score += score
	$GreenScore.text = str(green_score)


func _on_DetectionArea1_body_entered(_body):
	$BlueScoreTimer.start()


func _on_DetectionArea1_body_exited(_body):
	$BlueScoreTimer.stop()


func _on_DetectionArea2_body_entered(_body):
	$GreenScoreTimer.start();


func _on_DetectionArea2_body_exited(_body):
	$GreenScoreTimer.stop()


func _on_BlueScoreTimer_timeout():
	update_green_score(1)


func _on_GreenScoreTimer_timeout():
	update_blue_score(1)


func _on_GetReadyTimer_timeout():
	$Message.visible = false
