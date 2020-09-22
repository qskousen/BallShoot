extends VBoxContainer


func _ready():
	$HBoxContainer/OptionButton.add_item("Time", 0)
	$HBoxContainer/OptionButton.add_item("Score", 1)
	$HBoxContainer/OptionButton.add_item("None", 2)
	$HBoxContainer/OptionButton.selected = Globals.victory_condition
	$Score/SpinBox.value  = Globals.game_over_score
	$Time/SpinBox.value = Globals.game_over_time


func _on_OptionButton_item_selected(index):
	if index == 0:
		Globals.victory_condition = Globals.Goal.TIME
	if index == 1:
		Globals.victory_condition = Globals.Goal.SCORE
	if index == 2:
		Globals.victory_condition = Globals.Goal.NONE


func _on_time_SpinBox_value_changed(value):
	Globals.game_over_time = value


func _on_score_SpinBox_value_changed(value):
	Globals.game_over_score = value
