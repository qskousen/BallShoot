extends VBoxContainer


func _ready():
	$HSlider.value = -Globals.bullet_speed / 10 
	$HBoxContainer/Speed.text = str($HSlider.value)

func _on_HSlider_value_changed(value):
	$HBoxContainer/Speed.text = str(value)
	Globals.bullet_speed = -value * 10
