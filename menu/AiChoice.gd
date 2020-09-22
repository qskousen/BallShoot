extends VBoxContainer


func _ready(): 
	$HBoxContainer/OptionButton.add_item("Easy", 0)
	$HBoxContainer/OptionButton.add_item("Moderate", 1)
	$HBoxContainer/OptionButton.add_item("Hard", 2)
	$HBoxContainer/OptionButton.selected = Globals.ai_difficulty
	

func _on_OptionButton_item_selected(index):
	if index == 0:
		Globals.ai_difficulty = Globals.AiDifficulty.EASY
	elif index == 1:
		Globals.ai_difficulty = Globals.AiDifficulty.MODERATE
	elif index == 2:
		Globals.ai_difficulty = Globals.AiDifficulty.HARD
