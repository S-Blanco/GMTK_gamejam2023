extends Node2D


onready var gloryUI = $CanvasLayer/GloryUI
onready var dist = $CanvasLayer/GloryUI/distance
onready var healthUI =$CanvasLayer/HealthUI
onready var red = $CanvasLayer/HealthUI/Red
onready var TestEnemyMouvement = $TestEnemyMovement

func _process(_delta):
	if GlobalVariables.glory > 0.03 and GlobalVariables.glory <= gloryUI.max_glory:
		gloryUI.set_glory(GlobalVariables.glory)	

	if GlobalVariables.distance > 0:
		dist.text = "distance =" +str(GlobalVariables.distance)

	if GlobalVariables.damage > 0:
		healthUI.set_damage(GlobalVariables.damage)


func _on_TestEnemyMovement_hero_runs_again():
	print("hero starts runnung again")


func _on_TestEnemyMovement_hero_stopped():
	TestEnemyMouvement.woah_there(TestEnemyMouvement.get_children())
	# Cleme adds the call to start fight here
	print("hero stops to fight")
	TestEnemyMouvement.game_status="fighting"

func _on_TestEnemyMovement_hero_died():
	TestEnemyMouvement.get_children("Character").die()
	TestEnemyMouvement.spawn_player()
	print("hero died, send a new one")
