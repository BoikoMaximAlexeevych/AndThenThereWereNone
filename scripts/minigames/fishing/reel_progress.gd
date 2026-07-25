class_name ReelProgress
extends RefCounted
## Прогресс поимки [0..1]: растёт, пока рыба в зоне крючка, медленно спадает вне её.
## Полный прогресс = рыба поймана. Чистая логика — тестируемо.

var value: float

var _config: FishingConfig

func _init(config: FishingConfig) -> void:
	_config = config
	value = 0.0

func update(delta: float, overlapping: bool) -> void:
	if overlapping:
		value += delta / _config.catch_time
	else:
		value -= delta * _config.gap_penalty_per_sec
	value = clampf(value, 0.0, 1.0)

func is_caught() -> bool:
	return value >= 1.0
