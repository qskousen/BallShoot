extends CanvasLayer

var blue_score = 0
var green_score = 0

var message_updated_times = 0
var seconds = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	EventAggregator.listen("blue_entered", funcref(self, "_on_DetectionArea_blue_body_entered"))
	EventAggregator.listen("blue_exited", funcref(self, "_on_DetectionArea_blue_body_exited"))
	EventAggregator.listen("green_entered", funcref(self, "_on_DetectionArea_green_body_entered"))
	EventAggregator.listen("green_exited", funcref(self, "_on_DetectionArea_green_body_exited"))


func _input(event):
	if Input.is_action_pressed("ui_cancel") and not get_tree().paused:
		$Timers.pause_mode = Node.PAUSE_MODE_STOP
		get_tree().paused = true
	elif Input.is_action_just_pressed("ui_cancel") and get_tree().paused:
		$Timers.pause_mode = Node.PAUSE_MODE_INHERIT
		get_tree().paused = false


func update_blue_score(score):
	blue_score += score
	$BlueScore.text = str(blue_score)
	
	
func update_green_score(score):
	green_score += score
	$GreenScore.text = str(green_score)


func _on_DetectionArea_blue_body_entered():
	$Timers/BlueScoreTimer.start()


func _on_DetectionArea_blue_body_exited():
	$Timers/BlueScoreTimer.stop()


func _on_DetectionArea_green_body_entered():
	$Timers/GreenScoreTimer.start();


func _on_DetectionArea_green_body_exited():
	$Timers/GreenScoreTimer.stop()


func _on_BlueScoreTimer_timeout():
	update_green_score(1)


func _on_GreenScoreTimer_timeout():
	update_blue_score(1)


func _on_GetReadyTimer_timeout():
	if message_updated_times == 0:
		$Message.text = "Set!"
		$Timers/SecondTimer.start()
	elif message_updated_times == 1:
		$Message.text = "GO!"
	elif message_updated_times == 2:
		$Message.visible = false
		EventAggregator.shout("start_game_message_gone", [])
	elif message_updated_times >= 3:
		$Timers/GetReadyTimer.stop()
		return
	message_updated_times += 1
	$Timers/GetReadyTimer.stop()
	$Timers/GetReadyTimer.start()


func _on_SecondTimer_timeout():
	if seconds < 10:
		$Time.text = "0" + str(seconds)
	else:
		$Time.text = str(seconds)
	seconds += 1
