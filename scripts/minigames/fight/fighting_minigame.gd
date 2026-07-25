extends Minigame

@export var config: FightConfig

@export var player: Fighter
@export var enemy: Fighter
@export var cop: Cop
@export var hud: FightHud

var _is_fighting: bool = true
var _meter_value: float

func _ready() -> void:
	_meter_value = config.start_value
	cop.hide()
	hud.set_prompt("CLICK!")
	_update_visuals()

func _process(delta: float) -> void:
	if (!_is_fighting):
		return
	_meter_value -= config.drain_per_second * delta
	
	if (Input.is_action_just_pressed("mouse_click")):
		_meter_value += config.click_gain
	
	_update_visuals()
	_evaluate()
	
func _evaluate():
	if _meter_value <= 0.0:
		restart()
	
	if _meter_value >= 1.0:
		_win_fight()
	
func _update_visuals():
	var advantage := (_meter_value - 0.5) * 2.0
	player.set_advantage(advantage)
	enemy.set_advantage(-advantage)
	hud.set_progress(_meter_value)
	
func _win_fight():
	_is_fighting = false;
	hud.set_prompt("")
	enemy.play_defeat()
	await get_tree().create_timer(config.enemy_fall_time).timeout
	_start_cop()

func _start_cop() -> void:
	cop.show()
	cop.enter_and_strike(player.global_position, config.cop_enter_time)

func _on_cop_struck() -> void:
	player.play_defeat()
	await get_tree().create_timer(config.cop_strike_delay).timeout
	finish()
	
