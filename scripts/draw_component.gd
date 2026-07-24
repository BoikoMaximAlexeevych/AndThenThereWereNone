class_name DrawComponent extends Node2D

const LINE_WIDTH := 2.0
const LINE_COLOR := Color(1.0, 0.978, 0.898, 0.85)

var start: Vector2
var end: Vector2

var should_draw_line: bool = false

func _draw_line() -> void:
	draw_line(
	start,
	end,
	LINE_COLOR,
	LINE_WIDTH
	)

func _draw() -> void:
	if should_draw_line:
		_draw_line()
