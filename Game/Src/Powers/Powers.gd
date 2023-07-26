extends Node

onready var lightning = $LightningPower
onready var potion = $PotionPower
onready var slippery = $SlipperyHandsPower

var rng

signal glory_increment(value)
signal health_increase(value)

func _ready() -> void:
	randomize()
	rng = RandomNumberGenerator.new()

func call_pwr(slots,pwrList,toggle,otherArgs: Dictionary = {'stats':null,'enemy':null}):
	if not toggle.isEmpty:
		match slots:
			pwrList.lightning:
				lightning.lightning(otherArgs['enemy'])
				toggle.change_to_empty_texture()
			pwrList.potion:
				potion.potion(otherArgs['stats'])
				toggle.change_to_empty_texture()
			pwrList.slippery_hands:
				slippery.slippery_hands()
				toggle.change_to_empty_texture()

func fill_empty(toggles,slots) -> void:
	var idx = rng.randi_range(0, 3)
	if toggles[0].isEmpty:
		toggles[0].filling(idx)
		slots[0] = idx
		return
	elif not (toggles[0].isEmpty) and toggles[1].isEmpty:
		toggles[1].filling(idx)
		slots[1] = idx
		return
