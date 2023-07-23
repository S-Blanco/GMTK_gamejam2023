extends KinematicBody2D

onready var anim = $AnimationPlayer
onready var animTree = $AnimationTree
onready var animState = animTree.get("parameters/playback")
onready var stats = $PlayerStats

signal died

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func die():
	death_animation()
	emit_signal("died")
	queue_free()

func death_animation():
	anim.get_animation("Disappear")
	anim.play()
	pass
