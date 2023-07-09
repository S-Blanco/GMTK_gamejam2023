extends TextureButton

var textures = [preload("res://Assets/UI/EmptyPwr.png"),preload("res://Assets/UI/LightningPwr.png"),preload("res://Assets/UI/PotionPwr.png"),preload("res://Assets/UI/SlipperyHandPwr.png")]
export var texture_id = 1
onready var isEmpty = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func change_to_empty_texture():
	get_node(".").set_normal_texture(textures[0])
	isEmpty = true

func change_to_filled_texture():
	get_node(".").set_normal_texture(textures[texture_id])
	if texture_id != 0:
		isEmpty = false


# Called when the node enters the scene tree for the first time.
func _ready():
	change_to_empty_texture()
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	print(texture_id)
	pass


