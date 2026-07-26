class_name AnimationStateComponent extends Node

signal player_smoked

@export var movement_component: MovementComponent
@export var animation_tree: AnimationTree
@onready var input_component: InputComponent = %InputComponent


var velocity := 0.
var direction := Vector2.ZERO
var last_dir := 0.
var smoking := false
var dead := false


func update():
	velocity = movement_component.current_speed
	direction = movement_component.dir
	if input_component.smoke_pressed:
		smoking = true
		await get_tree().create_timer(5.).timeout
		smoking = false
		player_smoked.emit()
		
	if velocity != 0.:
		last_dir = direction.x
		
	animation_tree.set("parameters/Idle/blend_position", last_dir)
	animation_tree.set("parameters/Walk/blend_position", last_dir)
