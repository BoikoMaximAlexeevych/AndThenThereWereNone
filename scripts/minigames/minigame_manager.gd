extends Node2D

@export var minigames_data: Dictionary[Globals.MINIGAMES, MinigameData] = {}

var NUMBERS_IN_STRING = ["were none", "was one", "were two", "were three", "four", "five"]

#of course godot doesn't have sets
var _finished_minigames: Dictionary[Globals.MINIGAMES, bool]

func minigame_item(minigame_id: Globals.MINIGAMES):
	return minigames_data[minigame_id];

func is_minigame_finished(minigame_id: Globals.MINIGAMES):
	return _finished_minigames.has(minigame_id)
	
func set_minigame_finished(minigame_id: Globals.MINIGAMES):
	_finished_minigames.set(minigame_id, true)
	
	var leftAmount := minigames_data.size() - _finished_minigames.size()
	var text = "And then there " + NUMBERS_IN_STRING[leftAmount+1]
	
	SceneChangeManager.return_mode(text)
	SceneChangeManager.change_scene_to(Globals.SCENES.MAIN)
