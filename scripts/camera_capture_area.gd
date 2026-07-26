class_name HouseTransitionArea
extends Area2D

@export var collision_shape: CollisionShape2D
@export var marker: Marker2D
@export var room_scene: Globals.SCENES
@export var room_data: RoomData

var player_in_zone := false

func _ready() -> void:
	if (MinigameManager.is_minigame_finished(room_data.minigame)):
		queue_free()
	
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)
	SignalBus.player_enters_room.connect(_on_player_enters)

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and Globals.home_to_clear == room_data.order:
		(area as HitboxComponent).entered_camera_lock_area.emit(marker.global_position)
		SignalBus.character_can_enter_toggled.emit(self)
		SignalBus.show_hint.emit("E", "Enter")

func _on_area_exited(area: Area2D) -> void:
	if area is HitboxComponent and Globals.home_to_clear == room_data.order:
		SignalBus.character_can_enter_toggled.emit(self)
		(area as HitboxComponent).exited_camera_lock_area.emit()
		SignalBus.hide_hint.emit()

func _on_player_enters(room: HouseTransitionArea):
	if room == self:
		Globals.next_room_data = self.room_data
		SceneChangeManager.current_mode = SceneChangeManager.TRANSITION_MODES.REGULAR
		SceneChangeManager.change_scene_to(room_scene)
		Globals.home_to_clear += 1
