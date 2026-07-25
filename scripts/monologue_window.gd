extends CanvasLayer

@onready var label = $MarginContainer/PanelContainer/RichTextLabel
@onready var animPlayer: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

var character_lines: Array[String] = [
	"My job isn't a cheerful one",
	"In fact, it's qiute the opposite",
	"But someone has to tidy up dead people's houses before they get sold",
	"And someone is willing to pay for that",
	"It's only natural that you get a bit desensitized in a long run",
	"But I feel like witnessing the owner's death each time",
	"Each. Damn. Time."
]

var queue: Array[String]

func _ready() -> void:
	$MarginContainer.offset_transform_position.y = 400

func show_line(index: int, duration: float) -> void:
	label.text = character_lines[index]
	animPlayer.play("show")
	timer.wait_time = duration
	timer.start()
	await timer.timeout
	animPlayer.play("hide")
	pass

func add_to_queue(index: int) -> void:
	queue.append(character_lines[index])

func flush_queue() -> void:
	queue.clear()

func execute_queue() -> void:
	for line in queue:
		label.text = line
		animPlayer.play("show")
		await SignalBus.monologue_forward
		animPlayer.play("hide")
		await animPlayer.animation_finished
	flush_queue()
