extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready var Enemy = $Enemy
onready var Bckgnd = $Background/TextureRect
onready var stopScroll = 500
onready var scrollDist = 0
export(PackedScene) var Enemy_scn = preload("res://Src/Characters/Enemy.tscn")
export(int) var spawn_position = 2800
export(int) var spawn_y = 820

var base_scroll_speed
var base_pixel_speed
var curr_pixel_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	base_scroll_speed = Bckgnd.scroll_speed
	base_pixel_speed = base_scroll_speed*Bckgnd.texture.get_size().x
	curr_pixel_speed = base_pixel_speed
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var New_enemy
	scrollDist += delta*base_pixel_speed
#	print(scrollDist,' ',fmod(scrollDist,spawn_position),' ',delta*curr_pixel_speed,' ',spawn_position-delta*curr_pixel_speed)
	if (spawn_position-delta*curr_pixel_speed<fmod(scrollDist,spawn_position)) || (fmod(scrollDist,spawn_position)<delta*curr_pixel_speed):
#		print('should spawn',' ',fmod(scrollDist,spawn_position))
		New_enemy = Enemy_scn.instance()
		New_enemy.set_global_position(Vector2(spawn_position,spawn_y))
		New_enemy.pixel_speed=curr_pixel_speed
		add_child(New_enemy)
	for _i in self.get_children():
		print(_i)
