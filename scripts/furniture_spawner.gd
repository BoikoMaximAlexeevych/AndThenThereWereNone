class_name FurnitureSpawner extends Node2D

@export var shape_source: CollisionShape2D
@export var furniture_set: FurnitureSet

const furniture_scene = preload("res://scenes/draggable_furniture.tscn")

func random_point_in_shape() -> Vector2:
	var shape = shape_source.shape as RectangleShape2D
	var size_half = shape.size / 2.
	var point = Vector2(
		randf_range(-size_half.x, size_half.x),
		randf_range(-size_half.y, size_half.y),
	)
	return point + shape_source.position

func spawn_furniture() -> void:
	var cnt = 0
	var points: Array[Vector2]
	while cnt < furniture_set.furniture_num:
		var point = random_point_in_shape()
		var any_point_too_close = false
		for pnt in points:
			if point.distance_to(pnt) <= furniture_set.min_space:
				any_point_too_close = true
				break
		if any_point_too_close:
			continue
		else:
			points.append(point)
			cnt+=1
	for point in points:
		var scene = furniture_scene.instantiate() as DraggableFurniture
		add_child(scene)
		scene.global_position = point
		scene.rotation = randf_range(-60., 60.)
		scene.setup(furniture_set.furnitureTypes.pick_random())
