extends Node2D

class_name Spawner


@export var scene: PackedScene
@export var direction: int
@export var cooldown: float
@export var speed: float


@onready var spawn_timer: Timer = $SpawnTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.start(cooldown)
	spawn_object()


func spawn_object() -> void:
	if scene:
		var new_obj = scene.instantiate()
		new_obj.direction = direction
		new_obj.speed = speed
		call_deferred("add_child", new_obj)


func _on_spawn_timer_timeout() -> void:
	spawn_object()
