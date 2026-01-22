extends Node2D


func _on_timer_timeout() -> void:
	get_parent().call_deferred("queue_free")
