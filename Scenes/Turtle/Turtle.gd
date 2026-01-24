extends Area2D


@export var speed = 50.0
@export var direction = 1


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sprite_2d_2: Sprite2D = $Sprite2D2
@onready var death_box: Area2D = $DeathBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group(Log.GROUP_NAME)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += delta * speed * direction
	if direction > 0:
		sprite_2d.flip_h = true
		sprite_2d_2.flip_h = true


func _on_timer_timeout() -> void:
	death_box.set_deferred("monitoring", true)
	sprite_2d.frame = 1
	sprite_2d_2.frame = 1
	await get_tree().create_timer(2).timeout
	death_box.set_deferred("monitoring", false)
	sprite_2d.frame = 0
	sprite_2d_2.frame = 0


func _on_death_box_area_entered(area: Area2D) -> void:
	SignalHub.emit_on_died()
