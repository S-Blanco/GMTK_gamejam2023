extends KinematicBody2D

onready var anim = $AnimationPlayer
onready var animTree = $AnimationTree
onready var animState = animTree.get("parameters/playback")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func death_animation():
	anim.get_animation("Disappear")
	anim.play()
	queue_free()
	pass
