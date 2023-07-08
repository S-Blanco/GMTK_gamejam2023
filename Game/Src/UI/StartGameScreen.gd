extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	# TODO : reset glory and distance in global_var
	get_tree().change_scene("res://Src/World/world.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_SettingsButton_pressed():
	print("Open the settings page : keyboard control")
	get_tree().change_scene("res://Src/UI/Settings.tscn")

