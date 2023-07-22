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

func change_green(value:float)->void:
	green.rect_size.x = value*health_unit

func _on_PlayerStats_health_changed(value:float):
	change_green(value)
