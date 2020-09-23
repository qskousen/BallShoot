extends VBoxContainer


func _ready():
	$HSlider.value = Globals.bullet_life
	$HBoxContainer/Life.text = str($HSlider.value)

func _on_HSlider_value_changed(value):
	$HBoxContainer/Life.text = str(value)
	Globals.bullet_life = value
