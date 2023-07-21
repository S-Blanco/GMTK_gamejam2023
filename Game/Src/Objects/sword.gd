extends KinematicBody2D

onready var sprite = $swordsprite
onready var normalTexture = load('res://Assets/Objects/Sword.png')
onready var rusty1Texture = load('res://Assets/Objects/Sword-Rust1.png')
onready var rusty2Texture = load('res://Assets/Objects/Sword-Rust2.png')
onready var legendary1Texture = load('res://Assets/Objects/Sword-Epic1.png')
onready var legendary2Texture = load('res://Assets/Objects/Sword-EpicMax.png')

onready var max_glory = 100

enum epic {normal,rusty,ruined,epic,legendary}

func _ready():
	sprite.set_texture(normalTexture)

func _Glory_changed(value):
	print('Sword Glory changed ',value)
	if value <= 0.4*max_glory and value > 0.2*max_glory:
		print('Rusty 1')
		sprite.set_texture(rusty1Texture)
	elif value <= 0.2*max_glory:
		print('Rusty 2')
		sprite.set_texture(rusty2Texture)
	elif value <= 0.6*max_glory and value > 0.4*max_glory:
		print('Normal')
		sprite.set_texture(normalTexture)
	elif value <= 0.8*max_glory and value > 0.6*max_glory:
		print('Legendary 1')
		sprite.set_texture(legendary1Texture)
	elif value > 0.8*max_glory:
		print('Legendary 2')
		sprite.set_texture(legendary2Texture)
	pass # Replace with function body.
