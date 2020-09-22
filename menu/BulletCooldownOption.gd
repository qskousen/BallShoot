extends VBoxContainer


func _ready():
	$HSlider.value = Globals.cooldown
	$HBoxContainer/CooldownValue.text = str($HSlider.value)

func _on_HSlider_value_changed(value):
	$HBoxContainer/CooldownValue.text = str(value)
	Globals.cooldown = value
