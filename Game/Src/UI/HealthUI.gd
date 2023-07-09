extends Control

onready var stats = $StatsGen

onready var green =$Green
onready var red = $Red

var max_damage

func _ready():
	max_damage = green.rect_scale.x
	
func set_damage(value):
	print('health changed by ',value)
	GlobalVariables.damage = clamp(value, 0, max_damage)
	if red != null:
		red.rect_scale.x = value
		


