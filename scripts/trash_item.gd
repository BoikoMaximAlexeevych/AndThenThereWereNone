class_name TrashItem extends Area2D

signal picked(item: TrashItem)
signal bagged(item: TrashItem)

@export var Data: TrashItemData
@onready var sprite := $Sprite2D

var _collected: bool = false

func _ready() -> void:
	sprite.texture = Data.texture
	input_event.connect(_on_input_event)
	input_pickable = true

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	pass
