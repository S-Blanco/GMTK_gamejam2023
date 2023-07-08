extends Node2D


onready var gloryUI = $CanvasLayer/GloryUI
onready var dist = $CanvasLayer/GloryUI/distance
onready var healthUI =$CanvasLayer/HealthUI
onready var red = $CanvasLayer/HealthUI/Red

func _process(_delta):
	if GlobalVariables.glory > 0.03 and GlobalVariables.glory <= gloryUI.max_glory:
		gloryUI.set_glory(GlobalVariables.glory)	
		
	if GlobalVariables.distance > 0:
		dist.text = "distance =" +str(GlobalVariables.distance)
		
	if GlobalVariables.damage > 0:
		healthUI.set_damage(GlobalVariables.damage)
		

