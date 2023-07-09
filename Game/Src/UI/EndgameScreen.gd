extends Node2D

onready var lost_legend = $CanvasLayer/LostLabel_Legend
onready var lost_rubbish = $CanvasLayer/LostLabel_Rubbish
onready var label = $CanvasLayer/Label


func _process(delta):
	if GlobalVariables.glory >= 0.2:
		lost_legend.visible = true
	
	if GlobalVariables.glory <= 0:
		lost_rubbish.visible = true
		
	if GlobalVariables.distance >= 0:
		label.text = "But you've managed to last " +str(int(GlobalVariables.distance/1000)) + " days"


func _on_StartButton_pressed():
	
	GlobalVariables.glory = 0.1
	GlobalVariables.distance = 0
	
	get_tree().change_scene("res://Src/World/world.tscn")
	
	
func _on_QuitButton_pressed():
	get_tree().quit()
