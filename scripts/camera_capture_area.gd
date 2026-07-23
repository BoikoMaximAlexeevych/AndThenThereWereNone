class_name CameraCaptureArea
extends Area2D

@export var collision_shape: CollisionShape2D
@export var marker: Marker2D

func _ready() -> void:
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)

func _on_area_entered(area: Area2D) -> void:
	print("hey")
	if area is HitboxComponent:
		(area as HitboxComponent).entered_camera_lock_area.emit(marker.global_position)

func _on_area_exited(area: Area2D) -> void:
	if area is HitboxComponent:
		(area as HitboxComponent).exited_camera_lock_area.emit()
