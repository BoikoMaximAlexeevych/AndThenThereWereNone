class_name CameraControlComponent
extends Node

@export var hitbox_component: HitboxComponent
@export var camera: Camera2D
@export var body: CharacterBody2D

var in_area: bool = false
var area_focus_pos: Vector2

var camera_offset = Vector2(0., -32)

func _ready() -> void:
	hitbox_component.entered_camera_lock_area.connect(_on_entered_cla)
	hitbox_component.exited_camera_lock_area.connect(_on_exited_cla)
	

func _on_entered_cla(pos: Vector2):
	in_area = true
	area_focus_pos = pos

func _on_exited_cla():
	in_area = false
	area_focus_pos = Vector2.ZERO

func update():
	if in_area:
		camera.global_position = lerp(
			camera.global_position,
			area_focus_pos,
			0.05
		)
	else:
		if camera.global_position.distance_to(body.global_position + camera_offset) >= 10.:
			camera.global_position = lerp(
				camera.global_position,
				body.global_position + camera_offset,
				0.03
			)
func disable():
	pass

func enable():
	camera.global_position = body.global_position + Vector2(0., -32)
	camera.make_current()
