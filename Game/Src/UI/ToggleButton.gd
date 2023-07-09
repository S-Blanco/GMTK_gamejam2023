extends TextureButton

var texture_empty = preload("res://Assets/UI/no_power.png")
var texture_lightning = preload("res://Assets/UI/lightning_power.png")
var texture_id = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func change_to_empty_texture():
	get_node(".").set_normal_texture(texture_empty)

func change_to_filled_texture():
	get_node(".").set_normal_texture(texture_lightning)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	print(texture_id)
	pass


