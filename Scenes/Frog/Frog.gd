extends Area2D


const TILE_WIDHT: int = 40
const START_POS: Vector2 = Vector2(180, 580)


@onready var sprite_2d: Sprite2D = $Sprite2D


var on_water: bool = false
var logs_touched: int = 0 
var target_position: Vector2


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("up"):
		target_position.y -= TILE_WIDHT
		rotation_degrees = 0
	if Input.is_action_just_pressed("down"):
		target_position.y += TILE_WIDHT
		rotation_degrees = 180.0
	if Input.is_action_just_pressed("left"):
		target_position.x -= TILE_WIDHT
		rotation_degrees = -90
	if Input.is_action_just_pressed("right"):
		target_position.x += TILE_WIDHT
		rotation_degrees = 90.0
	target_position.x = clamp(target_position.x, 20, 340)
	target_position.y = clamp(target_position.y, 100, 580)
	if target_position != position:
		sprite_2d.frame = 1
	else:
		sprite_2d.frame = 0
	position = target_position


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = START_POS
	target_position = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_death()


func check_death() -> void:
	if on_water == true and logs_touched <= 0:
		die()


func die() -> void:
	position = START_POS
	target_position = position


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group(WaterDetect.GROUP_NAME):
		on_water = true
	if area.is_in_group("logs"):
		logs_touched += 1


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group(WaterDetect.GROUP_NAME):
		on_water = false
	if area.is_in_group("logs"):
		logs_touched -= 1
