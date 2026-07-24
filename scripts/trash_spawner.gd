class_name TrashSpawner extends Node2D

@export var shape_source: CollisionShape2D
@export var trash_set: TrashSetData

var items: Array[TrashItem]

const trash_scene = preload("res://scenes/trash_item.tscn")

func random_point_in_shape() -> Vector2:
	var shape = shape_source.shape as RectangleShape2D
	var size_half = shape.size / 2.
	var point = Vector2(
		randf_range(-size_half.x, size_half.x),
		randf_range(-size_half.y, size_half.y),
	)
	return point + shape_source.position

func spawn_trash() -> void:
	var how_many = randi_range(
		trash_set.min_items_in_room,
		trash_set.max_items_in_room
		)
	var cnt = 0
	var points: Array[Vector2]
	while cnt < how_many:
		var point = random_point_in_shape()
		var any_poin_too_close = false
		for pnt in points:
			if point.distance_to(pnt) <= trash_set.min_distance:
				any_poin_too_close = true
				break
		if any_poin_too_close:
			continue
		else:
			points.append(point)
			cnt+=1
	for point in points:
		var scene = trash_scene.instantiate() as TrashItem
		add_child(scene)
		scene.global_position = point
		scene.rotation = randf_range(-60., 60.)
		scene._setup(trash_set.trash_types.pick_random())
		items.append(scene)
