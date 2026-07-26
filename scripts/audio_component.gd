class_name AudioComponent extends Node

@export var steps_player: AudioStreamPlayer2D

func play_step() -> void: 
	steps_player.play()
