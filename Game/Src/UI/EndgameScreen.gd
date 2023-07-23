extends Node2D

onready var lost_legend = $CanvasLayer/LostLabel_Legend
onready var lost_rubbish = $CanvasLayer/LostLabel_Rubbish
onready var label = $CanvasLayer/Label
onready var sprite = $CanvasLayer/Sprite


func _ready():
	# Hide stuff first
	lost_rubbish.visible = false
	lost_legend.visible = false
	
	#Legendary
	if GlobalVariables.glory >= 100:
		lost_legend.visible = true
		lost_rubbish.visible = false
		sprite.texture = load('res://Assets/Objects/Sword-EpicMax.png')
		
	#Rubbish (weirdly enough, gains some glory while losing..., threshold is not zero but should)
	if GlobalVariables.glory <= 1:
		lost_rubbish.visible = true
		lost_legend.visible = false
		sprite.texture = load('res://Assets/Objects/Sword-Rust2.png')
		
	if GlobalVariables.distance >= 0:
		label.text = "But you've managed to last " +str(int(GlobalVariables.distance/1000)) + " days"


func _on_StartButton_pressed():
	GlobalVariables.glory = 50
	GlobalVariables.distance = 0
	GlobalVariables.damage = 0
	get_tree().change_scene("res://Src/World/world.tscn")
	
	
func _on_QuitButton_pressed():
	get_tree().quit()
