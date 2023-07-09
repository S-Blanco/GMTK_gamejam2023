extends Control


signal power1
signal power2

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


var count = 0
func _input(ev):
	if ev is InputEventKey and ev.pressed:
		count += 1
		if (ev.scancode == GlobalVariables.esc_key):
			get_tree().change_scene("res://Src/UI/Menu.tscn")
		elif ev.scancode == GlobalVariables.power1_key:
			emit_signal("power1")
			# send signal to buttons in UI?
		elif ev.scancode == GlobalVariables.power2_key:
			emit_signal("power2")
			# send signal to buttons in UI?
