extends Control


onready var full = $Full
onready var filling = $Filling 
var max_glory

func _ready():
	max_glory = full.rect_scale.x 

func set_glory(value):
	GlobalVariables.glory = clamp(value, 0.03, max_glory)
	if filling != null:
		filling.rect_scale.x = value
		



