extends Control

signal hero_starts_fighting
signal hero_runs_again # Cleme emits this signal when hero won fight
signal hero_died # Cleme emits this signal when hero lost fight



export(PackedScene) var enemyScn = preload("res://Src/Characters/Enemy.tscn")
export(PackedScene) var enemyScn2 = preload("res://Src/Characters/Enemy2.tscn")
export(PackedScene) var enemyScn3 = preload("res://Src/Characters/Enemy3.tscn")
export(PackedScene) var enemyScn4 = preload("res://Src/Characters/Enemy4.tscn")
export(PackedScene) var enemyScn5 = preload("res://Src/Characters/Enemy5.tscn")
export(PackedScene) var enemyScn6 = preload("res://Src/Characters/Enemy6.tscn")
export(PackedScene) var enemyScn7 = preload("res://Src/Characters/Enemy7.tscn")
export(PackedScene) var enemyScn8 = preload("res://Src/Characters/Enemy8.tscn")
export(PackedScene) var enemyScn9 = preload("res://Src/Characters/Enemy9.tscn")
export(PackedScene) var enemyScn10 = preload("res://Src/Characters/Enemy10.tscn")

export(PackedScene) var playerScn = preload("res://Src/Characters/Character.tscn")

export(int) var startSlow = 1200
export(int) var enemySpawnX = 2800
export(int) var spawn_y = 820
export(float) var slowTime = 1.5
export(int) var PLAYER_SPAWN_X = -200


#onready var Enemy = $Enemy
onready var Bckgnd = $Background/TextureRect
onready var charPlayer = $Character/AnimationPlayer
onready var charSprite = $Character/Sprite
onready var stopScroll = 800
onready var scrollDist = 0


onready var enemies = [enemyScn,enemyScn2,enemyScn3,enemyScn4,enemyScn5,enemyScn6,enemyScn7,enemyScn8,enemyScn9,enemyScn10]

var base_scroll_speed
var base_pixel_speed
var curr_pixel_speed
var curr_scroll_speed
var init_child_num
var rng = RandomNumberGenerator.new()

# variable used to indicate what action to perform in the game loop
enum game_status {RUNNING, FIGHTING, DROPPED}

# For the power ups, 0 means empty
# number from 1 to 9 will be associated
# with a unique power up/down
# the list of powers should be stored in an enum
# later so we can write, e.g. power_slots[0]=fire
enum powers {no_power,
			lightning,
			potion,
			slippery_hands
			}
var power_slots = [powers.no_power,powers.no_power]

onready var player_controls = $PlayerControls
onready var power1_toggle = $Power1Toggle
onready var power2_toggle = $Power2Toggle

var New_enemy
var children
var closest_enemy
var NMX
var idx
var current_game_status
var enemy_is_alive = false


# Called when the node enters the scene tree for the first time.
func _ready():
	current_game_status = game_status.RUNNING
	rng.randomize()

	base_scroll_speed = Bckgnd.scroll_speed
	base_pixel_speed = base_scroll_speed*Bckgnd.texture.get_size().x
	curr_pixel_speed = base_pixel_speed
	curr_scroll_speed = base_scroll_speed
	init_child_num = len(self.get_children())
	# $Character.connect('died',self,'spawn_player',[playerSpawnX])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(current_game_status)
	print(enemy_is_alive)
	scrollDist += delta*base_pixel_speed
	GlobalVariables.distance = scrollDist

#	Slowing down process
	children = self.get_children()
	if current_game_status == game_status.RUNNING:
		#	Enemy spawn
	#	the "\" split the if conditions on multiple line
		if not enemy_is_alive and\
			(enemySpawnX-delta*curr_pixel_speed<fmod(scrollDist,enemySpawnX)*0.99) or \
			(fmod(scrollDist,enemySpawnX)<delta*curr_pixel_speed*0.99):
			enemy_is_alive = true
			idx=rng.randi_range(0, len(enemies)-1)
			New_enemy = enemies[idx].instance()
			New_enemy.set_global_position(Vector2(enemySpawnX,spawn_y))
			New_enemy.pixel_speed=curr_pixel_speed
	#		add_child(New_enemy, name ="current_enemy")
			add_child(New_enemy)
		
		if len(children)>init_child_num and enemy_is_alive:
			closest_enemy = children[init_child_num]
			NMX = closest_enemy.get_global_position().x
			if (NMX<stopScroll+delta*curr_pixel_speed) and (NMX>stopScroll-delta*curr_pixel_speed):
				emit_signal("hero_starts_fighting")

	elif current_game_status == game_status.FIGHTING:
		# DEBUG press right to kill monster
		if Input.is_action_pressed("ui_right"):
			print('The enemy is killed, let s run again')
			emit_signal("hero_runs_again")
	#		closest_enemy.die()
	#		yield(children[init_child_num],'died')
	#		yield(children[init_child_num].anim,"finished")
	#		move_again(children,Bckgnd)
	#		$Character.die()
		# DEBUG : press left to die
		if Input.is_action_pressed("ui_left"):
			print('Your hero died')
			emit_signal("hero_died")
	else:
		pass


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

# stop the scrolling of the scene
func stop_scrolling(children):
	Bckgnd.set_scroll_speed(0.0)
	for i in range(init_child_num,len(children)):
		if not children[i].get("pixel_speed") == null:
			children[i].pixel_speed = 0.0
	charPlayer.stop()
	base_pixel_speed=0

	
	
func move_again(children):
	Bckgnd.set_scroll_speed(base_scroll_speed)
	base_pixel_speed = base_scroll_speed*Bckgnd.texture.get_size().x
	for i in range(init_child_num,len(children)):
		children[i].pixel_speed = base_pixel_speed
	charPlayer.play()


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

func spawn_player():
	var newPlayer
	newPlayer = playerScn.instance()
	newPlayer.set_global_position(Vector2(PLAYER_SPAWN_X,spawn_y))
	add_child(newPlayer)
	var tween = get_node("Tween")
	tween.interpolate_property(newPlayer, "position:x",PLAYER_SPAWN_X,242,2,Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween.start()
