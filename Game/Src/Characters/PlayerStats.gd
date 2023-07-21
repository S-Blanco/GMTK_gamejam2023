extends Node

export var maxHealth: int = 100
export var health: int = 100 setget set_health, get_health

signal health_changed(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_health(value):
	health = clamp(value,0,maxHealth)
	print('Changing health to ',health,' ',value)
	emit_signal("health_changed",health)

func get_health():
	return health
