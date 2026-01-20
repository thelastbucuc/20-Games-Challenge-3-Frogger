extends Area2D


class_name Frog


const TILE_SIZE: int = 40
const OFFSET: int = 20


@onready var sprite_2d: Sprite2D = $Sprite2D


var _on_water: bool = false
var _logs_touched: int = 0 
var _target_position: Vector2
var _current_log = null


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("up"):
		_target_position.y -= TILE_SIZE
		rotation_degrees = 0
	if Input.is_action_just_pressed("down"):
		_target_position.y += TILE_SIZE
		rotation_degrees = 180.0
	if Input.is_action_just_pressed("left"):
		_target_position.x -= TILE_SIZE
		rotation_degrees = -90
	if Input.is_action_just_pressed("right"):
		_target_position.x += TILE_SIZE
		rotation_degrees = 90.0
	_target_position.x = clamp(_target_position.x, 20, 340)
	_target_position.y = clamp(_target_position.y, 100, 580)
	if _target_position != position:
		sprite_2d.frame = 1
	else:
		sprite_2d.frame = 0
	position = _target_position
	_target_position.x = round((_target_position.x - OFFSET) / TILE_SIZE) * TILE_SIZE + OFFSET
	_target_position.y = round((_target_position.y - OFFSET) / TILE_SIZE) * TILE_SIZE + OFFSET


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_died.connect(on_died)
	_target_position = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _current_log != null:
		global_position.x += _current_log.speed * _current_log.direction * delta
	check_death()


func check_death() -> void:
	if _on_water == true and _logs_touched <= 0:
		SignalHub.emit_on_died()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group(Lillypad.GROUP_NAME):
		print("lilly")
		_on_water = false
		SignalHub.emit_on_died()
	if area.is_in_group(WaterDetect.GROUP_NAME):
		_on_water = true
	if area.is_in_group("logs"):
		_logs_touched += 1
		_current_log = area
	if area.is_in_group(Car.GROUP_NAME):
		SignalHub.emit_on_died()


func on_died() -> void:
	call_deferred("queue_free")
	#position = START_POS
	#_target_position = position


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group(WaterDetect.GROUP_NAME):
		_on_water = false
	if area.is_in_group("logs"):
		_logs_touched -= 1
		if area == _current_log:
			_current_log = null
			position.x = round((position.x - OFFSET) / TILE_SIZE) * TILE_SIZE + OFFSET
