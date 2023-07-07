extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var Enemy = $Enemy
onready var Bckgnd = $Background/TextureRect
onready var stopScroll = 500

var base_scroll_speed
var base_pixel_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	base_scroll_speed = Bckgnd.scroll_speed
	base_pixel_speed = Enemy.pixel_speed
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(Enemy.get_global_position())
	if Enemy.get_global_position().x <= stopScroll :
		print('Woah there')
		Bckgnd.set_scroll_speed(0.0)
		Enemy.pixel_speed = 0.0
		print(Bckgnd.scroll_speed)
#		Enemy.die()
		pass
