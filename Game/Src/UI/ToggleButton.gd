extends TextureButton

onready var textures = [preload("res://Assets/UI/EmptyPwr.png"),preload("res://Assets/UI/LightningPwr.png"),preload("res://Assets/UI/PotionPwr.png"),preload("res://Assets/UI/SlipperyHandPwr.png")]
onready var text_prog = $TextureProgress
onready var isEmpty: bool = true

export var texture_id: int = 1
export var cooldown: float = 2.0

onready var max_value: int = $TextureProgress.max_value

signal done_filling

func change_to_empty_texture() -> void:
	text_prog.value = 0
	isEmpty = true
	print('emptied')

func change_to_filled_texture() -> void:
	get_node(".").set_normal_texture(textures[texture_id])
	if texture_id != 0:
		isEmpty = false

func set_filled_texture(id:int) -> void:
	text_prog.set_progress_texture(textures[id])
	if id != 0:
		isEmpty = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	$Timer.wait_time = cooldown
#	filling(0)

func filling(id:int) -> void:
	set_filled_texture(id)
	$Timer.start()
	if id == 0:
		isEmpty = true
	else:
		isEmpty = false
		set_process(true)

func _process(delta):
	$Label.text = "%3.1f s" % $Timer.time_left
	text_prog.value = int((1-$Timer.time_left / cooldown) * max_value)

func _on_Timer_timeout():
	text_prog.value = max_value
	set_process(false)
	emit_signal("done_filling")
