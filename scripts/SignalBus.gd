extends Node

signal game_state_changed(new_state: Globals.GAME_STATE)

signal show_hint(key: String, hint: String)
signal hide_hint()

signal character_can_enter_toggled()

signal player_enters_room()
