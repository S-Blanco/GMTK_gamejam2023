extends Node2D

var flag = false   #flagging will be done when glory reaches 50 %
onready var gloryUI = $CanvasLayer/GloryUI
onready var dist = $CanvasLayer/GloryUI/distance
onready var healthUI =$CanvasLayer/HealthUI

onready var TestEnemyMouvement = $TestEnemyMovement
onready var characterStats = $TestEnemyMovement/Character/PlayerStats

func _ready():
	$CanvasLayer/GloryUI.set_glory(GlobalVariables.glory)

func _process(_delta):

	if GlobalVariables.glory > 0.000001 and flag == false:
#		gloryUI.set_glory(GlobalVariables.glory)	
		pass
		
	if GlobalVariables.glory >= 0.09:
		flag=true
		
	if GlobalVariables.glory >= gloryUI.max_glory:
		get_tree().change_scene("res://Src/UI/EndgameScreen.tscn")
		
	if GlobalVariables.glory <= 0:
		get_tree().change_scene("res://Src/UI/EndgameScreen.tscn")

	if GlobalVariables.distance > 0:
		dist.text = "You've lasted \n" + str( int(GlobalVariables.distance/1000)) + " days"
		
	if Input.is_action_pressed("test"):  #Just to demonstrate that if the button is pressed scene changes to end. 
		GlobalVariables.glory +=0.2
		

func _on_TestEnemyMovement_hero_runs_again():
#	print("hero starts running again")
	var enemy_child = TestEnemyMouvement.get_child(TestEnemyMouvement.get_child_count()-1)
	TestEnemyMouvement.current_game_status=TestEnemyMouvement.game_status.RUNNING
	if enemy_child is KinematicBody2D:
		enemy_child.die()
	TestEnemyMouvement.enemy_is_alive=false
	TestEnemyMouvement.move_again(TestEnemyMouvement.get_children())
	
func _on_TestEnemyMovement_hero_starts_fighting():
	TestEnemyMouvement.stop_scrolling(TestEnemyMouvement.get_children())
	# Cleme adds the call to start fight here
#	print("hero stops to fight")
	TestEnemyMouvement.current_game_status=TestEnemyMouvement.game_status.FIGHTING

func _on_TestEnemyMovement_hero_died():
	var hero_child = null
	for child in TestEnemyMouvement.get_children():
		if child.name == "Character":
			hero_child = child
			break
	if hero_child != null:
		print(hero_child.name)
		hero_child.die()
		TestEnemyMouvement.spawn_player()
		var last_child = TestEnemyMouvement.get_child(TestEnemyMouvement.get_child_count()-1)
		print(last_child.name)
		TestEnemyMouvement.current_game_status=TestEnemyMouvement.game_status.RUNNING
		GlobalVariables.damage = 0
#		print("hero died, send a new one")
	#	TestEnemyMouvement.current_game_status=TestEnemyMouvement.game_status.DROPPED
	# need this else pass for it to work. Without it, it tries to delete it before it exists?
	else:
		pass
