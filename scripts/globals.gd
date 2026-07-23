extends Node

enum SCENES {MENU, MAIN, ROOM1}
enum GAME_STATE{PLAY, CUTSCENE}


var MENU_PATH: String = "res://scenes/ui/main_menu.tscn"
var MAIN_SCENE_PATH: String = "res://scenes/game.tscn"
var ROOM1_PATH: String = "res://scenes/test_room_1.tscn"

var SCENES_DICT: Dictionary[SCENES, String] = {
	SCENES.MENU: MENU_PATH,
	SCENES.MAIN: MAIN_SCENE_PATH,
	SCENES.ROOM1: ROOM1_PATH
	}
