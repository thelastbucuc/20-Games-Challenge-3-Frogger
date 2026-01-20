extends Node2D


const START_POS: Vector2 = Vector2(180, 580)
const FROG = preload("uid://cnur81rrqova0")
const CAR = preload("uid://bovgf46dklj6y")
const LOG = preload("uid://dhqsq856a6gyo")


@onready var cars: Node2D = $Cars
@onready var logs: Node2D = $Logs

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_frog()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func spawn_cars() -> void:
	var y_pos = 340
	for row in 5:
		y_pos += 40
		print(row, y_pos)
		var new_car: Car = CAR.instantiate()
		new_car.global_position.y = y_pos
		new_car.global_position.x = 180 #random yap
		new_car.direction = -1
		cars.add_child(new_car)


func spawn_frog() -> void:
	var frog: Frog = FROG.instantiate()
	frog.global_position = START_POS
	add_child(frog)


func _on_car_timer_timeout() -> void:
	spawn_cars()
