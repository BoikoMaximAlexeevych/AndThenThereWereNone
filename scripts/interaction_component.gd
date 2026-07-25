class_name InteractionComponent extends Node

@export var input_component: InputComponent
var available_room: HouseTransitionArea

var character_can_enter := false

func _ready() -> void:
	SignalBus.character_can_enter_toggled.connect(_on_character_can_enter_toggled)

func update():
	if input_component.enter_pressed and character_can_enter:
		SignalBus.player_enters_room.emit(available_room)

func _on_character_can_enter_toggled(room: HouseTransitionArea):
	character_can_enter = not character_can_enter
	if character_can_enter:
			available_room = room
	
