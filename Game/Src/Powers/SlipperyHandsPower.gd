extends "res://Src/Powers/Powers.gd"

export var texture = preload("res://Assets/UI/SlipperyHandPwr.png")

func slippery_hands():
	emit_signal("glory_increment",-10)
