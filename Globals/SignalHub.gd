extends Node

signal on_died

func emit_on_died():
	on_died.emit()
