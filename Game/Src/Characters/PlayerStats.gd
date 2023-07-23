extends Node

export var maxHealth: int = 100
export var health: int = 100 setget set_health, get_health

signal health_changed(value)

func set_health(value):
	health = clamp(value,0,maxHealth)
	emit_signal("health_changed",health)

func get_health():
	return health
