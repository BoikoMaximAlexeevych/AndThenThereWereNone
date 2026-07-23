class_name MovementComponent
extends Node

@export var body: CharacterBody2D

@export_category("Movement Parameters")
@export var ACCELERATION: float = 200.
@export var MAX_SPEED: float = 60.
@export var FRICTION: float = 400.

var dir := Vector2.ZERO
var current_speed := .0

func tick(delta: float) -> void:
	if !body:
		return
	
	if abs(current_speed) < MAX_SPEED:
		current_speed += ACCELERATION * dir.x * delta
	else: 
		current_speed = MAX_SPEED * dir.x
	
	if !dir: 
		current_speed = move_toward(current_speed, 0., FRICTION)
	
	body.velocity.x = current_speed
	body.velocity.y += 300. * delta
	
	if body.is_on_floor():
		body.velocity.y = 0.
	
	body.move_and_slide()
