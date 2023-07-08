extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
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
var power_slots = [0,0]

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
	curr_scroll_speed = base_scroll_speed
	init_child_num = len(self.get_children())
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var New_enemy
	var children
	var closest_enemy
	var NMX
	
  scrollDist += delta*base_pixel_speed
  GlobalVariables.distance = scrollDist
  
# Enemy spawn
#	print(scrollDist,' ',fmod(scrollDist,spawn_position),' ',delta*curr_pixel_speed,' ',spawn_position-delta*curr_pixel_speed)
	if (spawn_position-delta*curr_pixel_speed<fmod(scrollDist,spawn_position)) || (fmod(scrollDist,spawn_position)<delta*curr_pixel_speed):
#		print('should spawn',' ',fmod(scrollDist,spawn_position))
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

#func slow_down(closest_enemy,startX,endX,slowTime):
#	var tween = get_node("Tween")
#	curr_pixel_speed = 0.0
#	tween.interpolate_property(closest_enemy, "position:x",
#		   startX,endX,slowTime,
#		   Tween.TRANS_CUBIC, Tween.EASE_IN)
#	tween.interpolate_property(Bckgnd, "material:shader_param/scroll_speed",
#		   base_pixel_speed,0.0,slowTime,
#		   Tween.TRANS_CUBIC, Tween.EASE_IN)
#	tween.start()
#	isSlowing = true
#	pass
#
#func speed_up():
#	isSlowing = false
#	var tween = get_node("Tween")
#	curr_pixel_speed = base_pixel_speed
##	tween.interpolate_property(closest_enemy, "position:x",
##	       startX,endX,slowTime,
##		   Tween.TRANS_CUBIC, Tween.EASE_IN)
##	tween.start()

func woah_there(children,bckgnd):
	bckgnd.set_scroll_speed(0.0)
	for i in range(init_child_num,len(children)):
		children[i].pixel_speed = 0.0
	charPlayer.stop()
	pass
	
  
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

