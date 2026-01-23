extends Control


const START_POS: Vector2 = Vector2(180, 580)
const FROG = preload("uid://cnur81rrqova0")


@onready var score_label: Label = $MC/ScoreLabel
@onready var lives_label: Label = $MC/LivesLabel
@onready var you_died: Control = $YouDied


var _score: int = 0
var _lives: int = 3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_scored.connect(on_scored)
	SignalHub.on_died.connect(on_died)
	score_label.text = "Score: %s" % _score
	lives_label.text = "Lives: %s" % _lives


func spawn_frog() -> void:
	var frog: Frog = FROG.instantiate()
	frog.global_position = START_POS
	get_parent().add_sibling(frog)


func handle_death() -> void:
	you_died.show()
	get_tree().paused = true
	await get_tree().create_timer(2).timeout
	you_died.hide()
	spawn_frog()
	get_tree().paused = false


func game_over() -> void:
	get_tree().paused = true
	print("Oyun Bitti!")


func on_scored() -> void:
	_score += 1
	score_label.text = "Score: %s" % _score


func on_died() -> void:
	if _score < get_tree().get_node_count_in_group(Lillypad.GROUP_NAME):
		_lives -= 1
		lives_label.text = "Lives: %s" % _lives
		if  _lives > 0:
			handle_death()
		else:
			game_over()
	
