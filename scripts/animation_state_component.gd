class_name AnimationStateComponent extends Node

@export var movement_component: MovementComponent
@export var animation_tree: AnimationTree

var velocity := 0.
var direction := Vector2.ZERO
var last_dir := 0.

func update():
	velocity = movement_component.current_speed
	direction = movement_component.dir
	
	if velocity != 0.:
		last_dir = direction.x
		
	animation_tree.set("parameters/Idle/blend_position", last_dir)
	animation_tree.set("parameters/Walk/blend_position", last_dir)
