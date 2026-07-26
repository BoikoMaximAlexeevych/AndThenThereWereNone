extends Node

enum GAME_STATE{PLAY, CUTSCENE}

# Resources to be loaded when ROOM1 gets called once more
var next_room_data: RoomData
var home_to_clear: int = 1

enum MINIGAMES {
	FIGHTING,
	FISHING
}

enum SCENES {
	MENU, 
	MAIN, 
	ROOM1,
	FIGHTING_MINIGAME,
	FISHING_MINIGAME,
	END_CREDITS,
}

var times_entered_main: int = 0


func increment_main_counter() -> void:
	times_entered_main += 1
