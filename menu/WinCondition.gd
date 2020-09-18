extends VBoxContainer


func _ready():
	Globals.victory_condition = Globals.Goal.SCORE
	Globals.game_over_time = $Score/SpinBox.value
	Globals.game_over_score = $Time/SpinBox.value


func _on_OptionButton_item_selected(index):
	if index == 0:
		Globals.victory_condition = Globals.Goal.SCORE
	if index == 1:
		Globals.victory_condition = Globals.Goal.TIME
	if index == 2:
		Globals.victory_condition = Globals.Goal.NONE


func _on_time_SpinBox_value_changed(value):
	Globals.game_over_time = value


func _on_score_SpinBox_value_changed(value):
	Globals.game_over_score = value
