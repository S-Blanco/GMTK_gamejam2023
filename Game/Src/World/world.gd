extends Node2D

var flag = false   #flagging will be done when glory reaches 50 %
onready var gloryUI = $CanvasLayer/GloryUI
onready var dist = $CanvasLayer/GloryUI/distance
onready var healthUI =$CanvasLayer/HealthUI
onready var red = $CanvasLayer/HealthUI/Red
onready var swordN = $TestEnemyMovement/Character/sword/swordsprite
onready var swordR1 = $TestEnemyMovement/Character/sword/Sprite_R1
onready var swordR2 = $TestEnemyMovement/Character/sword/Sprite_R2
onready var swordL1 = $TestEnemyMovement/Character/sword/Sprite_L1
onready var swordL2 = $TestEnemyMovement/Character/sword/Sprite_L2

onready var TestEnemyMouvement = $TestEnemyMovement

func _process(_delta):
	
	
	if GlobalVariables.glory > 0.000001 and flag == false:
		gloryUI.set_glory(GlobalVariables.glory)	
		
	if GlobalVariables.glory >= 0.09:
		flag=true
		
	if GlobalVariables.glory > 0.000001 and GlobalVariables.glory < 0.04 and flag == true:
		gloryUI.set_glory(GlobalVariables.glory)
		swordN.visible = false
		swordR1.visible = false
		swordR2.visible = true
		swordL1.visible = false
		swordL2.visible = false
		
	
	elif GlobalVariables.glory > 0.04 and GlobalVariables.glory < 0.08 and flag == true:
		gloryUI.set_glory(GlobalVariables.glory)
		swordN.visible = false
		swordR1.visible = true
		swordR2.visible = false
		swordL1.visible = false
		swordL2.visible = false
		
	elif GlobalVariables.glory > 0.08 and GlobalVariables.glory < 0.12 and flag == true:
		gloryUI.set_glory(GlobalVariables.glory)
		swordN.visible = true
		swordR1.visible = false
		swordR2.visible = false
		swordL1.visible = false
		swordL2.visible = false
		
	elif GlobalVariables.glory > 0.12 and GlobalVariables.glory < 0.16 and flag == true:
		gloryUI.set_glory(GlobalVariables.glory)
		swordN.visible = false
		swordR1.visible = false
		swordR2.visible = false
		swordL1.visible = true
		swordL2.visible = false
		
	elif GlobalVariables.glory > 0.16 and flag == true:
		gloryUI.set_glory(GlobalVariables.glory)
		swordN.visible = false
		swordR1.visible = false
		swordR2.visible = false
		swordL1.visible = false
		swordL2.visible = true
		
	
			
		

		
	if GlobalVariables.glory >= gloryUI.max_glory:
		get_tree().change_scene("res://Src/UI/EndgameScreen.tscn")
		



	if GlobalVariables.distance > 0:
		dist.text = "You've lasted \n" + str( int(GlobalVariables.distance/1000)) + " days"
		
	if GlobalVariables.damage > 0:
		healthUI.set_damage(GlobalVariables.damage)
		
	if GlobalVariables.damage >= healthUI.max_damage:
		pass #(here is where we would bring in the next character to pick up the sword)
		
	if Input.is_action_pressed("test"):  #Just to demonstrate that if the button is pressed scene changes to end. 
		GlobalVariables.glory +=0.2
		

func _on_TestEnemyMovement_hero_runs_again():
	print("hero starts running again")
	var last_child = TestEnemyMouvement.get_child(TestEnemyMouvement.get_child_count()-1)
	TestEnemyMouvement.current_game_status=TestEnemyMouvement.game_status.RUNNING
	last_child.die()
	
func _on_TestEnemyMovement_hero_stopped():
	TestEnemyMouvement.stop_scrolling(TestEnemyMouvement.get_children())
	# Cleme adds the call to start fight here
	print("hero stops to fight")
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
		TestEnemyMouvement.current_game_status=TestEnemyMouvement.game_status.FIGHTING
		print("hero died, send a new one")
	#	TestEnemyMouvement.current_game_status=TestEnemyMouvement.game_status.DROPPED
	# need this else pass for it to work. Without it, it tries to delete it before it exists?
	else:
		pass
