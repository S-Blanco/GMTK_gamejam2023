extends "res://Src/Powers/Powers.gd"

export var texture = preload("res://Assets/UI/LightningPwr.png")

func lightning(closest_enemy):
	if closest_enemy != null:
		closest_enemy.die()
