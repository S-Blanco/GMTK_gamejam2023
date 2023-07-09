extends Control

#onready var Enemy = $Enemy
onready var Bckgnd = $Background/TextureRect
onready var charPlayer = $Character/AnimationPlayer
onready var charSprite = $Character/Sprite
onready var stopScroll = 800
onready var scrollDist = 0
onready var isSlowing = false

export(PackedScene) var Enemy_scn = preload("res://Src/Characters/Enemy.tscn")
export(int) var startSlow = 1200
export(int) var spawn_position = 2800
export(int) var spawn_y = 820
export(float) var slowTime = 1.5

var base_scroll_speed
var base_pixel_speed
var curr_pixel_speed
var curr_scroll_speed
var init_child_num

# For the power ups, 0 means empty
# number from 1 to 9 will be associated
# with a unique power up/down
# the list of powers should be stored in an enum
# later so we can write, e.g. power_slots[0]=fire
enum powers {no_power,
			lightning,
			fire}
var power_slots = [powers.no_power,powers.no_power]

onready var player_controls = $PlayerControls
onready var power1_toggle = $Power1Toggle
onready var power2_toggle = $Power2Toggle

var New_enemy # why do we need to create a new var enemy each frame?
var children
var closest_enemy
var NMX

# Called when the node enters the scene tree for the first time.
func _ready():

	base_scroll_speed = Bckgnd.scroll_speed
	base_pixel_speed = base_scroll_speed*Bckgnd.texture.get_size().x
	curr_pixel_speed = base_pixel_speed
	curr_scroll_speed = base_scroll_speed
	init_child_num = len(self.get_children())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	scrollDist += delta*base_pixel_speed
	GlobalVariables.distance = scrollDist
  
# Enemy spawn
	if (spawn_position-delta*curr_pixel_speed<fmod(scrollDist,spawn_position)) || (fmod(scrollDist,spawn_position)<delta*curr_pixel_speed):
		New_enemy = Enemy_scn.instance()
		New_enemy.set_global_position(Vector2(spawn_position,spawn_y))
		New_enemy.pixel_speed=curr_pixel_speed
		add_child(New_enemy)
	
# Slowing down process
	children = self.get_children()
	if len(children)>init_child_num:
		closest_enemy = children[init_child_num]
		NMX = closest_enemy.get_global_position().x
		if (NMX<stopScroll+delta*curr_pixel_speed) && (NMX>stopScroll-delta*curr_pixel_speed):
			woah_there(children,Bckgnd)

func woah_there(children,bckgnd):
	bckgnd.set_scroll_speed(0.0)
	for i in range(init_child_num,len(children)):
		children[i].pixel_speed = 0.0
	charPlayer.stop()
	pass
	
  
func _on_PlayerControls_power1():
	if power_slots[0] == powers.no_power:
		power1_toggle.change_to_filled_texture()
		power_slots[0]= powers.lightning
	else:
		power1_toggle.change_to_empty_texture()
		power_slots[0] = powers.no_power
	
	
func _on_PlayerControls_power2():
	if power_slots[1] == powers.no_power:
		power2_toggle.change_to_filled_texture()
		power_slots[1]= powers.lightning
	else:
		power2_toggle.change_to_empty_texture()
		power_slots[1] = powers.no_power

