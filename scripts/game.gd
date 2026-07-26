extends Node2D

@export var player: Player
@export var environment: MainEnvironment
@export var cutscene_cam: Camera2D

func greeting_scenario() -> void: # lines 0 - 6
	cutscene_cam.make_current()
	var tween = get_tree().create_tween()
	MonologueWindow.add_to_queue(0)
	MonologueWindow.add_to_queue(1)
	MonologueWindow.add_to_queue(2)
	MonologueWindow.add_to_queue(3)
	MonologueWindow.add_to_queue(4)
	MonologueWindow.add_to_queue(5)
	MonologueWindow.add_to_queue(6)
	await get_tree().create_timer(2.).timeout
	MonologueWindow.execute_queue()
	
func fighter_reflect_scenario() -> void: # lines 7-9
	MonologueWindow.add_to_queue(7)
	MonologueWindow.add_to_queue(8)
	MonologueWindow.add_to_queue(9)
	MonologueWindow.add_to_queue(10)
	await get_tree().create_timer(1.).timeout
	MonologueWindow.execute_queue()

func angler_reflect_scenario() -> void: # lines 11-15
	MonologueWindow.add_to_queue(11)
	MonologueWindow.add_to_queue(12)
	MonologueWindow.add_to_queue(13)
	MonologueWindow.add_to_queue(14)
	MonologueWindow.add_to_queue(15)
	await get_tree().create_timer(1.).timeout
	MonologueWindow.execute_queue()

func _ready() -> void:
	Globals.increment_main_counter()
	match Globals.times_entered_main:
		1:
			player.global_position = environment.init_spawn_point.global_position
			SignalBus.player_cant_move.emit()
			greeting_scenario()
			SignalBus.player_can_move.emit()
		2:
			player.global_position = environment.fighter_spawn_point.global_position
			SignalBus.player_cant_move.emit()
			fighter_reflect_scenario()
			await MonologueWindow.finished_monologue
			SignalBus.player_can_move.emit()
			player.must_smoke()
			await player.animation_state_component.player_smoked
			await get_tree().create_timer(1.).timeout
			player.die()
			await get_tree().create_timer(5.).timeout
			SceneChangeManager.change_scene_to(Globals.SCENES.END_CREDITS)
		3:
			player.global_position = environment.angler_spawn_point.global_position
			SignalBus.player_cant_move.emit()
			angler_reflect_scenario()
			await MonologueWindow.finished_monologue
			player.must_smoke()
			await player.animation_state_component.player_smoked
			player.die()
			SceneChangeManager.change_scene_to(Globals.SCENES.END_CREDITS)
