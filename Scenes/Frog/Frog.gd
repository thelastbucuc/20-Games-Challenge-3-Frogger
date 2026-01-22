extends Area2D


class_name Frog


const TILE_SIZE: int = 40
const OFFSET: int = 20


@onready var sprite_2d: Sprite2D = $Sprite2D


var _on_water: bool = false
var _logs_touched: int = 0
var _current_log = null
var _is_died: bool = false


func _input(event: InputEvent) -> void:
	if Input:
		global_position.x = round((global_position.x - OFFSET) / TILE_SIZE) * TILE_SIZE + OFFSET
		global_position.y = round((global_position.y - OFFSET) / TILE_SIZE) * TILE_SIZE + OFFSET
		var _target_position: Vector2 = Vector2.ZERO
		if Input.is_action_just_pressed("up"):
			_target_position.y = -TILE_SIZE
		if Input.is_action_just_pressed("down"):
			_target_position.y = TILE_SIZE
		if Input.is_action_just_pressed("left"):
			_target_position.x = -TILE_SIZE
		if Input.is_action_just_pressed("right"):
			_target_position.x = TILE_SIZE
		global_position += _target_position
		global_position.x = clamp(global_position.x, 20, 340)
		global_position.y = clamp(global_position.y, 100, 580)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_died.connect(on_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _current_log != null:
		global_position.x += _current_log.speed * _current_log.direction * delta
	check_death()


func check_death() -> void:
	if _on_water == true and _logs_touched <= 0:
		_is_died = true


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group(Lillypad.GROUP_NAME):
		_on_water = false
	if area.is_in_group(WaterDetect.GROUP_NAME):
		_on_water = true
	#if area.is_in_group(Car.GROUP_NAME):
	if area.is_in_group("logs"):
		_logs_touched += 1
		_current_log = area


func on_died() -> void:
	call_deferred("queue_free")


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group(WaterDetect.GROUP_NAME):
		_on_water = false
	if area.is_in_group("logs"):
		_logs_touched -= 1
		if area == _current_log:
			_current_log = null
