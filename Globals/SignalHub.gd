extends Node

signal on_died
signal on_scored

func emit_on_died():
	on_died.emit()

func emit_on_scored():
	on_scored.emit()
