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

# For the power ups, 0 means nothing
# number from 1 to 9 will be associated
# with a unique power up/down
var power_slots = [1,0]

onready var player_controls = $PlayerControls
onready var power1_toggle = $Power1Toggle
onready var power2_toggle = $Power2Toggle


# onready var testt = get_node("res://Src/UI/PlayerControls.tscn")
# testt.connect("power1",self,_on_power1)

# Called when the node enters the scene tree for the first time.
func _ready():

	base_scroll_speed = Bckgnd.scroll_speed
	base_pixel_speed = base_scroll_speed*Bckgnd.texture.get_size().x
	curr_pixel_speed = base_pixel_speed
	

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
	#for _i in self.get_children():
	# 	print(_i)


func _on_PlayerControls_power1():
	if power_slots[0]==0:
		power1_toggle.change_to_filled_texture()
		power_slots[0]=1
	else:
		power1_toggle.change_to_empty_texture()
		power_slots[0] = 0
	
	
func _on_PlayerControls_power2():
	if power_slots[1]==0:
		power2_toggle.change_to_filled_texture()
		power_slots[1]=1
	else:
		power2_toggle.change_to_empty_texture()
		power_slots[1] = 0
	
