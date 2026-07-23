extends Node

enum SCENES{MENU, MAIN}
enum GAME_STATE{PLAY, CUTSCENE}


var MENU_PATH: String = "res://scenes/ui/main_menu.tscn"
var MAIN_SCENE_PATH: String = "res://scenes/game.tscn"

var SCENES_DICT: Dictionary[SCENES, String] = {
	SCENES.MENU: MENU_PATH,
	SCENES.MAIN: MAIN_SCENE_PATH
	}
