class_name RoomEnvironment extends Node2D

@export var tile_set_to_apply: TileSet

@onready var tile_map: TileMapLayer = $TileMapLayer

func apply_tileset() -> void:
	tile_map.tile_set = tile_set_to_apply.duplicate()
