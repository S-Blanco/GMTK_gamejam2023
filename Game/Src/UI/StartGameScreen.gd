extends Control

signal change_scene_to(path)

func _on_StartButton_pressed():
	# TODO : reset glory and distance in global_var
	emit_signal("change_scene_to","res://Src/World/world.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_SettingsButton_pressed():
	print("Open the settings page : keyboard control")
	emit_signal("change_scene_to","res://Src/UI/Settings.tscn")

