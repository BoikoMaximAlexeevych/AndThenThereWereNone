extends Node2D

enum MINIGAMES {
	FIGHTING,
	FISHING
}

@export var minigames_data: Dictionary[MINIGAMES, MinigameData] = {}
@export var canvas: CanvasLayer
@export var leftLabel: Label

var NUMBERS_IN_STRING = ["None", "One", "Two", "Three", "Four", "Five"]

#of course godot doesn't have sets
var _finished_minigames: Dictionary[MINIGAMES, bool]

func _on_ready():
	SignalBus.minigame_finished.connect(_on_minigame_finished)
	
func minigame_data(minigame_id: MINIGAMES):
	return minigames_data[minigame_id];

func is_minigame_finished(minigame_id: MINIGAMES):
	return _finished_minigames.has(minigame_id)

func _on_minigame_finished(minigame_id: MINIGAMES):
	_finished_minigames.set(minigame_id, true)
	
	canvas.show()
	
	var leftAmount := minigames_data.size() - _finished_minigames.size()
	leftLabel.text = "And then there were %d left" % leftAmount
	
	#temporary measure
	await get_tree().create_timer(2.0).timeout
	SceneChangeManager.change_scene_to(Globals.SCENES.MAIN)
