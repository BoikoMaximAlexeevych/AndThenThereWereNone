class_name MovementComponent
extends Node

@export var body: CharacterBody2D

@export_category("Movement Parameters")
@export var ACCELERATION: float = 200.
@export var MAX_SPEED: float = 60.

var dir := Vector2.ZERO
var current_speed := .0

func tick(delta: float) -> void:
	if !body:
		return
	
	if current_speed < MAX_SPEED:
		current_speed += ACCELERATION * delta
	else: 
		current_speed = MAX_SPEED
	
	body.velocity.x = current_speed
	
	body.move_and_collide(body.velocity * delta)
