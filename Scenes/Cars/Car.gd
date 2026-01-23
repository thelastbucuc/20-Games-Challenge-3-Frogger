extends Area2D


class_name Car


@export var speed = 50.0
@export var direction = 1


const GROUP_NAME: String = "cars"


@onready var sprite_2d: Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_random_color()
	add_to_group(GROUP_NAME)


func set_random_color() -> void:
	var i = randi_range(0,2)
	if i == 0:
		sprite_2d.frame = 0
	if i == 1:
		sprite_2d.frame = 2
	if i == 3:
		sprite_2d.frame = 4


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += delta * speed * direction
	if direction > 0:
		sprite_2d.flip_h = true
