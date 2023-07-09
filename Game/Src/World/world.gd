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
		lost_legend.visible = true
		label.visible = true
	
	if GlobalVariables.glory <= 0:
		lost_rubbish.visible = true
		label.visible = true
		
		
	if GlobalVariables.distance > 0:
		dist.text = "distance =" +str(GlobalVariables.distance)
		label.text = "But you managed to run" +str(GlobalVariables.distance) + "kms"
		
	if GlobalVariables.damage > 0:
		healthUI.set_damage(GlobalVariables.damage)
		

