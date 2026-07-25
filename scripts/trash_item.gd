class_name TrashItem extends Area2D

signal picked(item: TrashItem)
signal bagged(item: TrashItem)

var Data: TrashItemData
@onready var sprite := $Sprite2D
@export var flight_component: FlightComponent

var _collected: bool = false

func _ready() -> void:
	input_event.connect(_on_input_event)
	flight_component.flight_ended.connect(_on_flight_ended)
	input_pickable = true

func _setup(data: TrashItemData) -> void:
	if !data: 
		return
	sprite.texture = data.texture

func _fly_to(target: Vector2) -> void:
	flight_component.launch(target)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if _collected: 
		return
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			_collected = true
			input_pickable = false
			picked.emit(self)
			get_viewport().set_input_as_handled()

func _on_flight_ended() -> void:
	bagged.emit(self)
