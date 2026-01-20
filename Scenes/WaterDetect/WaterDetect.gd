extends Area2D

class_name WaterDetect

const GROUP_NAME: String = "water"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group(GROUP_NAME)
