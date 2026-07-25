extends CanvasLayer

var next_scene: Globals.SCENES

@export var scene_data: Dictionary[Globals.SCENES, PackedScene] = {}

@onready var animPlayer: AnimationPlayer = $AnimationPlayer
@onready var rect = $ColorRect
@onready var item_rect = $"to minigame transition/ColorRect"
@onready var item_sprite = $"to minigame transition/key item sprite"
@onready var item_label = $"to minigame transition/RichTextLabel"

enum TRANSITION_MODES{
	REGULAR,
	MINIGAME
}
var current_mode: TRANSITION_MODES = TRANSITION_MODES.REGULAR

func _ready() -> void:
	(rect.material as ShaderMaterial).set_shader_parameter("circle_expansion", 1.2)
	item_rect.modulate = Color(1.0, 1.0, 1.0, 0.0)
	item_label.modulate = Color(1.0, 1.0, 1.0, 0.0)

func minigame_mode(item_tex: Texture2D) -> void:
	current_mode = TRANSITION_MODES.MINIGAME
	item_sprite.texture = item_tex

func change_scene_to(scene: Globals.SCENES) -> void:
	next_scene = scene
	
	if animPlayer.is_playing():
		animPlayer.stop()
	match current_mode:
		TRANSITION_MODES.REGULAR:
			animPlayer.play("transition")
		TRANSITION_MODES.MINIGAME:
			animPlayer.play("minigame_transition")
			current_mode = TRANSITION_MODES.REGULAR
	
func _new_scene(): #called from the animation
	get_tree().call_deferred("change_scene_to_file", scene_data[next_scene].resource_path)
