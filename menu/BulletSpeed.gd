extends VBoxContainer


func _ready():
	Globals.bullet_speed = $HSlider.value
	$HBoxContainer/Speed.text = str($HSlider.value)

func _on_HSlider_value_changed(value):
	$HBoxContainer/Speed.text = str(value)
	Globals.bullet_speed = value
