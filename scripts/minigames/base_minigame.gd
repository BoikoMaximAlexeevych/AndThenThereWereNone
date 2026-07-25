class_name Minigame
extends Node2D

@export var minigame_id: Globals.MINIGAMES

func finish() -> void:
	MinigameManager.set_minigame_finished(minigame_id)

func restart() -> void:
	get_tree().reload_current_scene()
