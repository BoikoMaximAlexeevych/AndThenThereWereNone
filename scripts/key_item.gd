class_name KeyItem extends Area2D

signal picked(key_item:KeyItem)

@onready var animPlayer: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var collider: CollisionShape2D = $CollisionShape2D

var minigame_scene: Globals.SCENES

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	input_event.connect(_on_input_event)
	self.visible = false
	
func setup(data: MinigameData) -> void:
	sprite.texture = data.icon
	var rect = RectangleShape2D.new()
	rect.size = data.icon.get_size()
	collider.shape = rect
	self.minigame_scene = data.scene

func appear() -> void:
	animPlayer.play("appear")
	pass

func _on_mouse_entered() -> void:
	animPlayer.play("bounce")
	pass
	
func _on_mouse_exited() -> void:
	animPlayer.stop()
	pass

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			picked.emit(self)
