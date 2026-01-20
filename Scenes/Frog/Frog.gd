extends Area2D


const TILE_WIDHT: int = 40
const START_POS: Vector2 = Vector2(180, 580)


@onready var sprite_2d: Sprite2D = $Sprite2D


var _on_water: bool = false
var _logs_touched: int = 0 
var _target_position: Vector2
var current_log = null


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("up"):
		_target_position.y -= TILE_WIDHT
		rotation_degrees = 0
	if Input.is_action_just_pressed("down"):
		_target_position.y += TILE_WIDHT
		rotation_degrees = 180.0
	if Input.is_action_just_pressed("left"):
		_target_position.x -= TILE_WIDHT
		rotation_degrees = -90
	if Input.is_action_just_pressed("right"):
		_target_position.x += TILE_WIDHT
		rotation_degrees = 90.0
	_target_position.x = clamp(_target_position.x, 20, 340)
	_target_position.y = clamp(_target_position.y, 100, 580)
	if _target_position != position:
		sprite_2d.frame = 1
	else:
		sprite_2d.frame = 0
	position = _target_position


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = START_POS
	_target_position = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_log != null:
		global_position.x += current_log.speed * current_log.direction * delta
	check_death()


func check_death() -> void:
	if _on_water == true and _logs_touched <= 0:
		die()


func die() -> void:
	position = START_POS
	_target_position = position


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group(WaterDetect.GROUP_NAME):
		_on_water = true
	if area.is_in_group(Log.GROUP_NAME):
		_logs_touched += 1
		current_log = area
		print("Kütüğün üzerine binildi: ", area.name)


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group(WaterDetect.GROUP_NAME):
		_on_water = false
	if area.is_in_group(Log.GROUP_NAME):
		_logs_touched -= 1
		if area == current_log:
			current_log = null
			print("Kütükten inildi.")
