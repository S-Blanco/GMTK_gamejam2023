extends Node2D


onready var lost_legend = $CanvasLayer/LostLabel_Legend
onready var lost_rubbish = $CanvasLayer/LostLabel_Rubbish
onready var label = $CanvasLayer/Label

func _process(delta):
	if GlobalVariables.glory >= 0.2:
		lost_legend.visible = true
		label.visible = true
	
	if GlobalVariables.glory <= 0:
		lost_rubbish.visible = true
		label.visible = true
		
	if GlobalVariables.distance >= 0:
		label.text = "But you managed to run" +str(GlobalVariables.distance) + "kms"
