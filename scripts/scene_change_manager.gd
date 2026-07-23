extends CanvasLayer

var nsp: String

@onready var animPlayer: AnimationPlayer = $AnimationPlayer
@onready var rect = $ColorRect

func _ready() -> void:
	(rect.material as ShaderMaterial).set_shader_parameter("circle_expansion", 1.2)

func change_scene_to(scene: Globals.SCENES) -> void:
	nsp = Globals.SCENES_DICT[scene]
	
	if animPlayer.is_playing():
		animPlayer.stop()
	animPlayer.play("transition")
	
func _new_scene(): #called from the animation
	get_tree().call_deferred("change_scene_to_file", nsp)
