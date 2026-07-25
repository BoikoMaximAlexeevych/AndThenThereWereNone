extends Control

func _on_play_button_pressed() -> void:
	SceneChangeManager.change_scene_to(Globals.SCENES.MAIN)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
