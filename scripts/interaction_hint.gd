extends Control

enum MODE{player, fixed}

@export var player: Player
@export var mode: MODE
@export var viewport: SubViewport

@onready var _key: RichTextLabel = $MarginContainer/HBoxContainer/ColorRect/RichTextLabel
@onready var _hint: RichTextLabel = $MarginContainer/HBoxContainer/RichTextLabel
@onready var animPlayer: AnimationPlayer = $AnimationPlayer

@export var active: bool = false

func _ready() -> void:
	SignalBus.show_hint.connect(_on_show_hint)
	SignalBus.hide_hint.connect(_on_hide_hint)

func _process(delta: float) -> void:
	if active:
		self.position = player.ui_marker.get_screen_position()
		await animPlayer.animation_finished
		animPlayer.play("press_button")

func _on_show_hint(key: String, hint: String):
	animPlayer.play("appear")
	_key.text = key
	_hint.text = hint
	
func _on_hide_hint():
	animPlayer.play_backwards("appear")
	_key.text = ""
	_hint.text = ""
