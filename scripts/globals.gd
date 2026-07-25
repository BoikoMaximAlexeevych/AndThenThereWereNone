extends Node

enum GAME_STATE{PLAY, CUTSCENE}

# Resources to be loaded when ROOM1 gets called once more
var next_room_data: RoomData

enum MINIGAMES {
	FIGHTING,
	FISHING
}

enum SCENES {
	MENU, 
	MAIN, 
	ROOM1,
	FIGHTING_MINIGAME,
	FISHING_MINIGAME
}
