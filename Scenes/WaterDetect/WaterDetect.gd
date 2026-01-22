extends Area2D

class_name WaterDetect

const GROUP_NAME: String = "water"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group(GROUP_NAME)


func _on_area_entered(area: Area2D) -> void:
	print("water")
