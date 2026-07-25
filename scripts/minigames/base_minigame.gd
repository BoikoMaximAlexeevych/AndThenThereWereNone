class_name Minigame
extends Node2D

@export var minigame_id: MinigameManager.MINIGAMES

func finish() -> void:
	SignalBus.minigame_finished.emit(minigame_id)

func restart() -> void:
	get_tree().reload_current_scene()
