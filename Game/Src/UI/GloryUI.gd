extends Control

onready var full = $Full
onready var filling = $Filling 
export var max_glory = 100

signal glory_changed(value)

var glory_unit

func _ready():
	glory_unit = full.rect_size.x / max_glory
#	print('glory_unit ',glory_unit)

func set_glory(value):
	GlobalVariables.glory = clamp(value, 0, max_glory)
#	print('setting glory to ',value)
#	print('rect_size ',value*glory_unit)
	if filling != null:
#		print('changing')
		filling.rect_size.x = value*glory_unit
	emit_signal("glory_changed",value)	

func _on_TestEnemyMovement_glory_increased(value):
	var newGlory = clamp(GlobalVariables.glory+value, 0, max_glory)
#	print('Adding ',value,' to glory')
#	print('starting glory ',GlobalVariables.glory)
#	print('final glory ',newGlory)
	GlobalVariables.glory = newGlory
#	print('final glory ',GlobalVariables.glory)
	if filling != null:
		filling.rect_size.x = newGlory*glory_unit
	emit_signal("glory_changed",newGlory)	
