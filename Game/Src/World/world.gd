extends Node2D


onready var gloryUI = $CanvasLayer/GloryUI
onready var dist = $CanvasLayer/GloryUI/distance
onready var healthUI =$CanvasLayer/HealthUI
onready var red = $CanvasLayer/HealthUI/Red
onready var lost_legend = $EndgameScreen/CanvasLayer/LostLabel_Legend
onready var lost_rubbish = $EndgameScreen/CanvasLayer/LostLabel_Rubbish
onready var label = $EndgameScreen/CanvasLayer/Label



func _process(_delta):
	
	
	if GlobalVariables.glory > 0.03:
		gloryUI.set_glory(GlobalVariables.glory)	
		
	if GlobalVariables.glory >= gloryUI.max_glory:
		get_tree().change_scene("res://Src/UI/EndgameScreen.tscn")
		
	if GlobalVariables.distance > 0:
		GlobalVariables.distance = GlobalVariables.distance/1000
		dist.text = "distance =" +str(GlobalVariables.distance)
		
		
	if GlobalVariables.damage > 0:
		healthUI.set_damage(GlobalVariables.damage)
		
	if GlobalVariables.damage >= healthUI.max_damage:
		pass #(here is where we would bring in the next character to pick up the sword)
		
	if Input.is_action_pressed("test"):  #Just to demonstrate that if the button is pressed scene changes to end. 
		GlobalVariables.glory +=0.2
		




