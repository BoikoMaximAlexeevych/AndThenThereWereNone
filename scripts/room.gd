extends Node2D
@export_category("Resources")
@export var room_data: RoomData
@export var key_item_data: KeyItemData
@export_category("Scene Components")
@export var environment: RoomEnvironment
@export var trash_spawner: TrashSpawner 
@export var furniture_spawner: FurnitureSpawner
@export var trash_bin_pos: Marker2D

var key_item: KeyItem
var _items_remaining: int = 0

var key_item_scene = preload("res://scenes/key_item.tscn")

func _ready() -> void:
	self.room_data = Globals.next_room_data
	setup_from_room_data()
	trash_spawner.spawn_trash()
	furniture_spawner.spawn_furniture()
	_items_remaining = trash_spawner.items.size()
	for item in trash_spawner.items:
		item.picked.connect(_on_trash_picked)
		item.bagged.connect(_on_trash_bagged)
	key_item = key_item_scene.instantiate() as KeyItem
	key_item.picked.connect(_on_key_item_picked)
	key_item.global_position = trash_spawner.get_viewport_rect().get_center()

func setup_from_room_data() -> void:
	environment.tile_set_to_apply = room_data.tile_set
	environment.apply_tileset()	
	trash_spawner.trash_set = room_data.trash_set
	furniture_spawner.furniture_set = room_data.furniture_set
	self.key_item_data = room_data.key_item_data
	
func _on_trash_picked(item: TrashItem) -> void:
	item.z_index = 50
	item._fly_to(trash_bin_pos.global_position)

func _on_trash_bagged(item: TrashItem) -> void:
	item.visible = false
	item.queue_free()
	_items_remaining -= 1
	if _items_remaining <= 0:
		_reveal_key_item()

func _reveal_key_item() -> void:
	trash_spawner.add_child(key_item)
	key_item.setup(key_item_data)
	key_item.appear()

func _on_key_item_picked(picked_key_item: KeyItem) -> void:
	SceneChangeManager.minigame_mode(picked_key_item.sprite.texture)
	SceneChangeManager.change_scene_to(picked_key_item.minigame_scene)
