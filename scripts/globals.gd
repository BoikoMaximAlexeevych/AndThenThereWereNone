extends Node

enum SCENES {
	MENU, 
	MAIN, 
	ROOM1,
	FIGHTING_MINIGAME,
	}
enum GAME_STATE{PLAY, CUTSCENE}


var MENU_PATH: String = "res://scenes/ui/main_menu.tscn"
var MAIN_SCENE_PATH: String = "res://scenes/game.tscn"
var ROOM1_PATH: String = "res://scenes/room.tscn"
var FIGHTING_PATH: String = "res://scenes/fighting_minigame.tscn"

var SCENES_DICT: Dictionary[SCENES, String] = {
	SCENES.MENU: MENU_PATH,
	SCENES.MAIN: MAIN_SCENE_PATH,
	SCENES.ROOM1: ROOM1_PATH,
	SCENES.FIGHTING_MINIGAME: FIGHTING_PATH,
	}
	
# Resources to be loaded when ROOM1 gets called once more

var next_room_data: RoomData
var next_key_item: KeyItemData
