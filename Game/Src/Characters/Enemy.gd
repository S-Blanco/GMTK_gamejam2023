extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var scroll_speed = 0.2 

onready var pixel_speed = scroll_speed*1920*3
onready var stats = $StatsEnemy
onready var anim = $AnimationPlayer

signal died

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide(Vector2(-pixel_speed,0))
	pass

func die():
#	queue_free()
	print('Enemy dead')
	death_animation()
	emit_signal('died')

#func remove_instance():
#	queue_free()
#	pass

func kill():
#	update_glory(self.glory_malus)
	pass

func _on_Visibility_screen_exited():
	GlobalVariables.glory = GlobalVariables.glory + 0.03
	GlobalVariables.damage += 0.03
	queue_free() # Replace with function body.

func death_animation():
	anim.play("Disappear")
