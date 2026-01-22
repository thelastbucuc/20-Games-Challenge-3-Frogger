extends Control

const START_POS: Vector2 = Vector2(180, 580)
const FROG = preload("uid://cnur81rrqova0")

@onready var score_label: Label = $MC/ScoreLabel
@onready var lives_label: Label = $MC/LivesLabel


var _score: int = 0
var _lives: int = 3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_scored.connect(on_scored)
	SignalHub.on_died.connect(on_died)
	call_deferred("spawn_frog")
	score_label.text = "Score: %s" % _score
	lives_label.text = "Lives: %s" % _lives


func spawn_frog() -> void:
	var frog: Frog = FROG.instantiate()
	frog.global_position = START_POS
	call_deferred("add_child", frog)


func on_scored() -> void:
	_score += 1
	score_label.text = "Score: %s" % _score


func on_died() -> void:
	if _score < get_tree().get_node_count_in_group(Lillypad.GROUP_NAME) and _lives > 1:
		call_deferred("spawn_frog")
	_lives -= 1
	lives_label.text = "Lives: %s" % _lives 
