extends CharacterBody2D

@export_category("Components")
@export var input_component: InputComponent
@export var movement_component: MovementComponent

func _update_components(delta: float) -> void:
	input_component.update()
	movement_component.tick(delta)
	
func _physics_process(delta: float) -> void:
	_update_components(delta)
