class_name DragComponent extends Node

@export var body: DraggableFurniture
@export var draw_component: DrawComponent

var _grab_pos_local: Vector2
var in_focus: bool = false
var grabbed: bool = false

const STIFFNESS := 40.0
const DAMPING := 6.0
const MAX_FORCE := 6000.0
const FURNITURE_MASK := 1


func _ready() -> void:
	body.area.mouse_entered.connect(_on_mouse_entered)
	body.area.mouse_exited.connect(_on_mouse_exited)

func update():
	if !body:
		return
	if grabbed:
		update_grab()
	
func update_grab() -> void:
	var grab_pos_global = body.to_global(_grab_pos_local)
	var vec_to_mouse = body.get_global_mouse_position() - grab_pos_global
	var force = vec_to_mouse * STIFFNESS * body.mass 
	force -= body.linear_velocity * DAMPING * body.mass
	force = force.limit_length(MAX_FORCE)
	body.apply_force(force, grab_pos_global - body.global_position)
	update_line()
	draw_component.queue_redraw()

func update_line() -> void:
	var grab_world = body.to_global(_grab_pos_local)
	var mouse = body.get_global_mouse_position()
	draw_component.start = grab_world
	draw_component.end = mouse

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if in_focus:
				_grab_pos_local = body.to_local(body.get_global_mouse_position())
				grab()
				get_viewport().set_input_as_handled()
		else:
			release()

func grab()->void:
	grabbed = true
	draw_component.should_draw_line = true
	
func release()->void:
	grabbed = false
	draw_component.should_draw_line = false
	draw_component.queue_redraw()
	
func _on_mouse_entered() -> void:
	print("hey")
	in_focus = true

func _on_mouse_exited() -> void:
	in_focus = false
