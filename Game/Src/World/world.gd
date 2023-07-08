extends Node2D


onready var gloryUI = $CanvasLayer/GloryUI
onready var dist = $CanvasLayer/GloryUI/distance

func _process(_delta):
	if GlobalVariables.glory > 0.03:
		gloryUI.set_glory(GlobalVariables.glory)
		
	if GlobalVariables.distance > 0:
		dist.text = "distance =" +str(GlobalVariables.distance)
		

