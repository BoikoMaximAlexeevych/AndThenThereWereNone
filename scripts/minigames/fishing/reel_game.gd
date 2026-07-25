class_name ReelGame
extends Node2D
## «Специальное окно» ловли (по мотивам Stardew): удержать значок рыбы в зоне крючка,
## пока прогресс не заполнится (~catch_time секунд суммарного перекрытия).
## Крючок поднимается зажатой ЛКМ, гравитация тянет вниз; рыба рыщет по треку.

signal caught

const TRACK_WIDTH := 36.0
const TRACK_HEIGHT := 220.0
const PROGRESS_WIDTH := 6.0
const PROGRESS_GAP := 4.0
const BORDER_WIDTH := 1.5

const COLOR_TRACK := Color(0.10, 0.16, 0.22, 0.9)
const COLOR_HOOK := Color(0.35, 0.75, 0.45, 0.5)
const COLOR_FISH := Color(0.95, 0.6, 0.3, 1.0)
const COLOR_PROGRESS_BG := Color(0.0, 0.0, 0.0, 0.4)
const COLOR_PROGRESS := Color(0.95, 0.85, 0.35, 1.0)
const COLOR_BORDER := Color(0.8, 0.85, 0.9, 0.8)

var _config: FishingConfig
var _hook: HookBar
var _progress: ReelProgress
var _active := false

var _fish_pos := 0.5
var _fish_target := 0.5
var _fish_timer := 0.0

func configure(config: FishingConfig) -> void:
	_config = config

func start() -> void:
	_hook = HookBar.new(_config)
	_progress = ReelProgress.new(_config)
	_fish_pos = 0.5
	_pick_fish_target()
	_active = true
	visible = true
	queue_redraw()

func stop() -> void:
	_active = false
	visible = false

func _process(delta: float) -> void:
	if not _active:
		return
	_hook.update(delta, Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT))
	_update_fish(delta)
	var reach := _config.hook_size * 0.5 + _config.fish_half
	_progress.update(delta, absf(_hook.position - _fish_pos) <= reach)
	queue_redraw()
	if _progress.is_caught():
		_active = false
		caught.emit()

func _update_fish(delta: float) -> void:
	_fish_timer -= delta
	if _fish_timer <= 0.0:
		_pick_fish_target()
	_fish_pos = move_toward(_fish_pos, _fish_target, _config.fish_speed * delta)

func _pick_fish_target() -> void:
	_fish_target = randf_range(_config.fish_half, 1.0 - _config.fish_half)
	_fish_timer = randf_range(_config.fish_move_interval_min, _config.fish_move_interval_max)

func _draw() -> void:
	draw_rect(Rect2(0.0, 0.0, TRACK_WIDTH, TRACK_HEIGHT), COLOR_TRACK)
	draw_rect(Rect2(0.0, 0.0, TRACK_WIDTH, TRACK_HEIGHT), COLOR_BORDER, false, BORDER_WIDTH)
	if _hook == null:
		return
	var hook_h := _config.hook_size * TRACK_HEIGHT
	var hook_y := (1.0 - _hook.position) * TRACK_HEIGHT - hook_h * 0.5
	draw_rect(Rect2(0.0, hook_y, TRACK_WIDTH, hook_h), COLOR_HOOK)
	var fish_h := _config.fish_half * 2.0 * TRACK_HEIGHT
	var fish_y := (1.0 - _fish_pos) * TRACK_HEIGHT - fish_h * 0.5
	draw_rect(Rect2(4.0, fish_y, TRACK_WIDTH - 8.0, fish_h), COLOR_FISH)
	var px := TRACK_WIDTH + PROGRESS_GAP
	draw_rect(Rect2(px, 0.0, PROGRESS_WIDTH, TRACK_HEIGHT), COLOR_PROGRESS_BG)
	var ph := _progress.value * TRACK_HEIGHT
	draw_rect(Rect2(px, TRACK_HEIGHT - ph, PROGRESS_WIDTH, ph), COLOR_PROGRESS)
