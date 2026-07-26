extends Minigame

enum Phase { CAST, WAIT_BITE, REEL, OTHER }

@export var cast_point_node: Node
@export var boat: Sprite2D
@export var fisher: Sprite2D
@export var line: Line2D
@export var bobber: Sprite2D
@export var big_fish: Sprite2D
@export var reel: ReelGame
@export var fish_count: Label
@export var prompt: Label
@export var config: FishingConfig

@onready var animation_player: AnimationPlayer = $CanvasLayer/SubViewportContainer/SubViewport/AnimationPlayer


const BIGFISH_LUNGE_OFFSET := Vector2(46.0, -28.0)
const CATCH_PAUSE := 0.5

var _phase: Phase = Phase.CAST
var _caught := 0

func _ready() -> void:
	reel.configure(config)
	reel.stop()
	big_fish.hide()
	line.hide()
	bobber.hide()
	_update_count()
	_enter_cast()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (_phase == Phase.CAST && Input.is_action_just_pressed("mouse_click")):
		_cast()

func _enter_cast() -> void:
	_phase = Phase.CAST
	line.hide()
	bobber.hide()
	prompt.text = "Click — start fishing"
	
func _cast() -> void:
	_phase = Phase.WAIT_BITE
	prompt.text = "Waiting..."
	bobber.global_position = cast_point_node.global_position
	line.points = PackedVector2Array([fisher.global_position, cast_point_node.global_position])
	line.show()
	bobber.show()
	await get_tree().create_timer(randf_range(config.bite_delay_min, config.bite_delay_max)).timeout
	if _phase != Phase.WAIT_BITE:
		return
	_start_bite()

func _start_bite() -> void:
	_phase = Phase.REEL
	prompt.text = "LMB - keep fish in the green zone"
	reel.start()

func _big_fish_sequence() -> void:
	_phase = Phase.OTHER
	prompt.text = ""
	line.hide()
	bobber.hide()
	big_fish.show()
	_eat_boat()

func _eat_boat() -> void:
	animation_player.play("eat_boat")
	await animation_player.animation_finished
	finish()

func _update_count() -> void:
	fish_count.text = "Fish caught: %d/%d" % [_caught, config.fish_to_catch]

func _on_reel_game_caught() -> void:
	if _phase != Phase.REEL:
		return
	reel.stop()
	_caught += 1
	_update_count()
	if _caught >= config.fish_to_catch:
		_big_fish_sequence()
	else:
		prompt.text = "GOT IT!"
		await get_tree().create_timer(CATCH_PAUSE).timeout
		_enter_cast()
