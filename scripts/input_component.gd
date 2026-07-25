class_name InputComponent
extends Node

var movement_direction: Vector2 = Vector2.ZERO
var jump_pressed: bool = false
var enter_pressed: bool = false
var monologue_skip_pressed: bool = false

func update() -> void:
	movement_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	jump_pressed = Input.is_action_just_pressed("move_jump")
	enter_pressed = Input.is_action_just_pressed("interact")
	monologue_skip_pressed = Input.is_action_just_pressed("monologue_skip")
	
