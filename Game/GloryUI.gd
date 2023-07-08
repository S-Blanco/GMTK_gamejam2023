extends Control


var glory = 0.03 setget set_glory
var max_glory = 0.5 


onready var full = $Full
onready var filling = $Filling 

func set_glory(value):
	glory = clamp(value, 0.03, max_glory)
	if filling != null:
		filling.rect_scale.x = value
		



