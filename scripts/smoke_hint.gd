extends Control

enum MODE{player, fixed}

@export var player: Player
@export var mode: MODE
@export var viewport: SubViewport

@onready var animPlayer: AnimationPlayer = $AnimationPlayer

@export var active: bool = false

func _ready() -> void:
	SignalBus.show_smoke_hint.connect(_on_show_hint)
	SignalBus.hide_smoke_hint.connect(_on_hide_hint)

func _process(delta: float) -> void:
	if active:
		self.position = player.ui_marker.get_screen_position()

func _on_show_hint():
	animPlayer.play("appear")

	
func _on_hide_hint():
	animPlayer.play_backwards("appear")
