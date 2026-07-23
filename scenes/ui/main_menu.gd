extends Control



func _on_play_button_pressed() -> void:
	SceneChangeManager.change_scene_to(Globals.SCENES.MAIN)
