class_name Cop
extends Node2D

signal struck

@export var offscreen_offset: Vector2 = Vector2(340.0, 0.0)
@export var stand_offset: Vector2 = Vector2(46.0, -6.0)
@export var baton_raised_deg: float = -115.0
@export var baton_hit_deg: float = 25.0
@export var baton_swing_time: float = 0.16

@export var baton: Node2D

func enter_and_strike(target: Vector2, enter_time: float) -> void:
	var end_pos:= target + stand_offset
	global_position = end_pos + offscreen_offset
	baton.rotation = deg_to_rad(baton_raised_deg)
	var tween := create_tween()
	tween.tween_property(self, "global_position", end_pos, enter_time).set_trans(Tween.TRANS_QUAD)\
			.set_ease(Tween.EASE_OUT)
	tween.tween_callback(_swing)
	
func _swing() -> void:
	var tween := create_tween()
	tween.tween_property(baton, "rotation", deg_to_rad(baton_hit_deg), baton_swing_time).set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_IN)
	tween.tween_callback(func() -> void: struck.emit())
