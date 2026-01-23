extends Area2D


class_name Log


@export var speed = 50.0
@export var direction = 1


const GROUP_NAME: String = "logs"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group(GROUP_NAME)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += delta * speed * direction
