class_name FlightComponent extends Node

signal flight_ended

const DURATION = 0.5
const ARCH_HEIGHT = 20.
const END_SCALE = 0.2

var _target: Vector2
var _start: Vector2
var _start_scale: Vector2

@export var body: Area2D

func launch(target: Vector2) -> void:
	if !body:
		return
	_target = target
	_start = body.global_position
	_start_scale = body.scale
	var tween := create_tween()
	tween.tween_method(_apply, 0.0, 1.0, DURATION)
	tween.finished.connect(func() -> void: flight_ended.emit())

func _apply(t: float) -> void:
	if body == null:
		return
	var pos := _start.lerp(_target, Easing.ease_out_back(t))
	pos.y -= Easing.arc(t) * ARCH_HEIGHT
	body.global_position = pos
	body.scale = _start_scale.lerp(_start_scale * END_SCALE, Easing.ease_out_cubic(t))
