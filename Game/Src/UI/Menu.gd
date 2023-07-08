extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_RestartButton_pressed():
	# TODO : reset glory and distance in global_var
	print("Restart the game, set glory to 50 and distance to 0")
	# get_tree().change_scene("res://Src/TestEnemyMovement.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()


func _on_ContinueButton_pressed():
	print("Continue the current game")
	# NOTE : We should save the last monster position to go in and out of the menu
	# and get back to the exact same scene
	# get_tree().change_scene("res://Src/TestEnemyMovement.tscn")


func _on_SettingsButton_pressed():
	print("Open the settings page : keyboard control")
	get_tree().change_scene("res://Src/UI/Settings.tscn")
