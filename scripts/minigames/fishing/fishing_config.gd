class_name FishingConfig
extends Resource
## Настройки мини-игры «рыбалка» — data-driven тюнинг баланса и таймингов.

## Диапазон задержки поклёвки после заброса, секунды.
@export var bite_delay_min: float = 1.0
@export var bite_delay_max: float = 2.5
## Сколько суммарно секунд перекрытия нужно, чтобы поймать рыбу.
@export var catch_time: float = 2.0
## Скорость спада прогресса, пока рыба вне зоны крючка (в долях/сек).
@export var gap_penalty_per_sec: float = 0.35
## Физика крючка (в нормализованных единицах трека [0..1]).
@export var hook_lift: float = 7.0
@export var hook_gravity: float = 5.0
@export var hook_max_speed: float = 1.7
## Размер зоны крючка (доля высоты трека).
@export var hook_size: float = 0.22
## Полуразмер значка рыбы (доля высоты трека).
@export var fish_half: float = 0.06
## Движение рыбы по треку: скорость и интервал смены цели.
@export var fish_speed: float = 1.2
@export var fish_move_interval_min: float = 0.4
@export var fish_move_interval_max: float = 1.1
## Сколько рыб поймать до появления большой рыбы.
@export var fish_to_catch: int = 5
## Тайминги финальной сцены большой рыбы.
@export var bigfish_rise_time: float = 0.9
@export var bigfish_eat_time: float = 0.6
