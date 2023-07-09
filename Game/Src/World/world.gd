extends Node2D


onready var gloryUI = $CanvasLayer/GloryUI
onready var dist = $CanvasLayer/GloryUI/distance
onready var healthUI =$CanvasLayer/HealthUI
onready var red = $CanvasLayer/HealthUI/Red
onready var TestEnemyMouvement = $TestEnemyMovement



func _process(_delta):
	
	
	if GlobalVariables.glory > 0.03:
		gloryUI.set_glory(GlobalVariables.glory)

		
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
	TestEnemyMouvement.woah_there(TestEnemyMouvement.get_children())
	# Cleme adds the call to start fight here
	print("hero stops to fight")
	TestEnemyMouvement.current_game_status=TestEnemyMouvement.game_status.FIGHTING

func _on_TestEnemyMovement_hero_died():
	var hero_child = TestEnemyMouvement.get_child(1)
	hero_child.die()
	TestEnemyMouvement.spawn_player()
	print("hero died, send a new one")
	TestEnemyMouvement.current_game_status=TestEnemyMouvement.game_status.DROPPED
