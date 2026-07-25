class_name Player extends CharacterBody2D

@export_category("Components")
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var camera_control_component: CameraControlComponent
@export var animation_state_component: AnimationStateComponent
@export var interaction_component: InteractionComponent

@onready var visibles := $visibleItems

@onready var ui_marker: Control = $UI_Marker

func _update_components(delta: float) -> void:
	input_component.update()
	movement_component.dir = input_component.movement_direction
	movement_component.tick(delta)
	camera_control_component.update()
	animation_state_component.update()
	interaction_component.update()
	
func _physics_process(delta: float) -> void:
	_update_components(delta)
