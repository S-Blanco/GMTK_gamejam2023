extends CanvasLayer

export(PackedScene) var currentScene = preload("res://Src/UI/StartGameScreen.tscn")
export(PackedScene) var nextScene = preload("res://Src/World/world.tscn")

onready var transMngr = $TransitionManager

signal changed_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CurrentScene.add_child(currentScene.instance())
	reconnect($CurrentScene,'change_scene_to','do_transition')

func do_transition(path_to_scene:String)->void:
	nextScene = load(path_to_scene).instance()
	$TransitionManager.play_animation("FadeOut")
	yield($TransitionManager/AnimationPlayer,'animation_finished') # I would like to yield the signal emitted by transition manager itself instead
	_change_scene_to($CurrentScene,nextScene)
	yield(self,'changed_scene')
	$TransitionManager.play_animation("FadeIn")
	yield($TransitionManager/AnimationPlayer,'animation_finished') # I would like to yield the signal emitted by transition manager itself instead

func _change_scene_to(currentScene:Node,nextScene:Node)->void:
	currentScene.get_child(0).queue_free()
	yield(currentScene.get_child(0),"tree_exited")
	currentScene.add_child(nextScene)
	reconnect(currentScene,'change_scene_to','do_transition')
	emit_signal("changed_scene")

func reconnect(scene:Node,signalName:String,methodName:String):
	scene.get_child(0).connect(signalName,self,methodName)
