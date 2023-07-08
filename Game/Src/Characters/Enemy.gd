extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var scroll_speed = 0.2 
onready var pixel_speed = scroll_speed*1920*3

onready var stats = $StatsEnemy

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide(Vector2(-pixel_speed,0))
	pass

func die():
#	play_death_animation
#	self.queue_free()
#	update_glory(self.glory_bonus)
	print('Player dead')
	pass

func kill():
#	update_glory(self.glory_malus)
	pass


func _on_Visibility_screen_exited():
	GlobalVariables.glory += 0.03
	queue_free() # Replace with function body.
