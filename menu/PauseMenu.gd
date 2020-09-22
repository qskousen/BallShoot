extends Control


func _on_Quit_pressed():
	get_tree().quit()


func _on_MainMenu_pressed():
	get_tree().change_scene("res://menu/Menu.tscn")


func _on_Return_pressed():
	EventAggregator.shout("game_continue", [])


func _on_Restart_pressed():
	EventAggregator.shout("game_restart", [])
