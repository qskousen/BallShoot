extends Control

func _on_Local_Play_pressed():
	get_tree().change_scene("res://Main.tscn")


func _on_Quit_pressed():
	get_tree().quit()
