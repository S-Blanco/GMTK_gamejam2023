extends Node

onready var anim = $AnimationPlayer
onready var rect = $ColorRect
onready var dissolve_shader = preload('res://Src/Shaders/dissolution_shader.tres')

onready var animsList = anim.get_animation_list()

signal transition_started
signal transition_finished

func _ready() -> void:
#	$ColorRect.color = Color(0,0,0,0)
	anim.play("RESET")

func play_animation(animName:String) -> void:
	if not(animName in animsList):
		push_error('Animation %s does not exist within curent player.'%animName)
#	print('Playin %s'%animName)
	emit_signal("transition_started")
	anim.play(animName)
	emit_signal("transition_finished")

func remove_material() -> void:
	rect.material.shader = null

func set_material():
	rect.material.shader = dissolve_shader
