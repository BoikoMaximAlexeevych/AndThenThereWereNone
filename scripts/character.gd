extends CharacterBody2D

@export_category("Components")
@export var input_component: InputComponent
@export var movement_component: MovementComponent

@onready var visibles := $visibleItems

var flip := true

func _update_components(delta: float) -> void:
	input_component.update()
	movement_component.dir = input_component.movement_direction
	movement_component.tick(delta)
	
func _physics_process(delta: float) -> void:
	if input_component.movement_direction and (velocity.x > 0) != flip:
		flip = velocity.x >= 0
	visibles.scale.x = 1 if flip else -1
	_update_components(delta)
