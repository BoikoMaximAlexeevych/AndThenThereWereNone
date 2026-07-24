class_name DraggableFurniture
extends RigidBody2D

@export var Data: FurnitureData
@onready var collider: CollisionShape2D = $CollisionShape2D
@onready var mouse_grabber: CollisionShape2D = $Area2D/CollisionShape2D
@export var area: Area2D
@export_category("Components")
@export var drag_component: DragComponent
@onready var sprite = $Sprite2D
@onready var shadow = $Shadow

func _ready() -> void:
	gravity_scale = 0.

func _apply_data() -> void:
	if !Data:
		return
	sprite.texture = Data.texture
	self.mass = Data.mass
	self.linear_damp = Data.friction  * 8.
	self.angular_damp = self.linear_damp
	#physics material removed (maybe i will bring it back)
	var rect_shape = RectangleShape2D.new()
	rect_shape.size = Data.texture.get_size()
	collider.shape = rect_shape
	mouse_grabber.shape = rect_shape
	
func setup(data: FurnitureData) -> void:
	sprite.texture = data.texture
	shadow.texture = data.texture
	self.mass = data.mass
	self.linear_damp = data.friction  * 8.
	self.angular_damp = self.linear_damp
	var rect_shape = RectangleShape2D.new()
	rect_shape.size = data.texture.get_size()
	collider.shape = rect_shape
	mouse_grabber.shape = rect_shape

func update_components(delta:float) -> void:
	drag_component.update()

func _physics_process(delta: float) -> void:
	var to_center = self.position - get_viewport_rect().get_center()
	shadow.global_position = self.global_position - to_center.normalized() * 3
	update_components(delta)
