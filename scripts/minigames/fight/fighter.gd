class_name Fighter
extends Sprite2D
#leans in the process

@export var push_distance: float = 40.0
@export var max_lean_deg: float = 12.0
@export var facingRight: bool = true

var _home_x: float
var _facing: float

func _ready() -> void:
	_home_x = position.x
	_facing = 1.0 if facingRight else -1.0

func set_advantage(amount: float) -> void:
	position.x = _home_x + _facing * push_distance * amount
	rotation = deg_to_rad(_facing * max_lean_deg * amount)

func play_defeat() -> void:
	var tween := create_tween()
	tween.tween_property(self, "rotation", deg_to_rad(_facing * 82.0), 0.5).set_trans(Tween.TRANS_BACK)\
			.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "modulate:a", 0.35, 0.5)
