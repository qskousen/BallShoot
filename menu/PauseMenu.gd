extends Control


func _ready():
	EventAggregator.listen("game_over", funcref(self, "_game_over"))

func _on_Quit_pressed():
	get_tree().quit()


func _on_MainMenu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to(Globals.main_menu)


func _on_Return_pressed():
	EventAggregator.shout("game_continue", [])


func _on_Restart_pressed():
	EventAggregator.shout("game_restart", [])
	

func _game_over():
	$VBoxContainer/Return.visible = false
