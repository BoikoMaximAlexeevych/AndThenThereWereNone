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

var next_room_data: RoomData

var times_entered_main: int = 0

func greeting_scenario() -> void: # lines 0 - 6
	MonologueWindow.add_to_queue(0)
	MonologueWindow.add_to_queue(1)
	MonologueWindow.add_to_queue(2)
	MonologueWindow.add_to_queue(3)
	MonologueWindow.add_to_queue(4)
	MonologueWindow.add_to_queue(5)
	MonologueWindow.add_to_queue(6)
	MonologueWindow.execute_queue()
	

func increment_main_counter() -> void:
	times_entered_main += 1
	await get_tree().create_timer(1.).timeout
	match times_entered_main:
		1:
			greeting_scenario()
