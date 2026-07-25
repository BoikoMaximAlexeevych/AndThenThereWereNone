class_name HookBar
extends RefCounted
## Физика «крючка» в окне ловли: позиция [0..1] (0 — низ, 1 — верх).
## Зажатая ЛКМ поднимает, гравитация тянет вниз. Чистая логика — тестируемо.

var position: float
var velocity: float

var _config: FishingConfig

func _init(config: FishingConfig) -> void:
	_config = config
	position = 0.5
	velocity = 0.0

func update(delta: float, holding: bool) -> void:
	var accel := _config.hook_lift if holding else -_config.hook_gravity
	velocity = clampf(velocity + accel * delta, -_config.hook_max_speed, _config.hook_max_speed)
	position += velocity * delta
	if position <= 0.0:
		position = 0.0
		velocity = 0.0
	elif position >= 1.0:
		position = 1.0
		velocity = 0.0
