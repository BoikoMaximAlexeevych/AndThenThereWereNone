class_name InputComponent
extends Node

@onready var animation_state_component: AnimationStateComponent = $"../AnimationStateComponent"

var must_smoke: bool = false
var can_move: bool = true

var movement_direction: Vector2 = Vector2.ZERO
var jump_pressed: bool = false
var enter_pressed: bool = false
var monologue_skip_pressed: bool = false
var smoke_pressed: bool = false

func _ready() -> void:
	SignalBus.player_cant_move.connect(_make_stand)
	SignalBus.player_can_move.connect(_let_move)

func update() -> void:
	if can_move and not animation_state_component.smoking and not must_smoke:
		movement_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		jump_pressed = Input.is_action_just_pressed("move_jump")
		enter_pressed = Input.is_action_just_pressed("interact")
	monologue_skip_pressed = Input.is_action_just_pressed("monologue_skip")
	smoke_pressed = must_smoke and Input.is_action_just_pressed("smoke")

func _let_move():
	can_move = true
	
func _make_stand():
	can_move = false
