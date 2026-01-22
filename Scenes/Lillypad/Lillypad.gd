extends Area2D


class_name Lillypad


const GROUP_NAME: String = "lillypads"


@onready var full: Sprite2D = $full


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group(GROUP_NAME)


func _on_area_entered(area: Area2D) -> void:
	print("lillypad")
	if full.visible == false:
		full.show()
		SignalHub.emit_on_scored()
