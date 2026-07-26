extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var can_quit: bool = false

func _ready() -> void:
	animation_player.play("appear")

func allow_quit() -> void:
	can_quit = true

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey or event is InputEventMouseButton:
		if can_quit: 
			get_tree().quit()
