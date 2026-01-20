extends Area2D


class_name Log


const GROUP_NAME: String = "logs"
const SPEED: float = 50.0


var _direction: float = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group(GROUP_NAME)


func get_direction() -> float:
	return _direction


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += delta * SPEED * get_direction()
