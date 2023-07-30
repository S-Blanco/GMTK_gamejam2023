extends "res://Src/Powers/Powers.gd"

export var texture = preload("res://Assets/UI/SlipperyHandPwr.png")

export(int, -100,0) var glory_loss = -10

func slippery_hands():
	emit_signal("glory_increment",glory_loss)
