extends "res://Src/Powers/Powers.gd"

export var texture = preload("res://Assets/UI/PotionPwr.png")

func potion(characterStats):
	var playerHealth = characterStats.get_health()
	characterStats.set_health(playerHealth+10)
