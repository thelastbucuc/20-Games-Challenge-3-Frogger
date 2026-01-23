extends Area2D


class_name Turtle


@export var speed = 50.0
@export var direction = 1


const GROUP_NAME: String = "logs"


@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group(GROUP_NAME)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += delta * speed * direction
	if direction > 0:
		sprite_2d.flip_h = true
