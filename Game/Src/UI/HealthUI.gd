extends Control

onready var stats = $StatsGen
onready var green =$Green
onready var red = $Red
onready var size = red.rect_size.x
export var max_health = 100

export(PackedScene) var statsScript

var health_unit

func _ready():
	health_unit = size / max_health
	print('Health unit ',size,' ',health_unit,' ',max_health)
	pass

func change_red(value:float)->void:
	print('changing red ',value,' ',value*health_unit)
	green.rect_size.x = value*health_unit
	print(value)

func _on_PlayerStats_health_changed(value:float):
	change_red(value)
	pass # Replace with function body.
