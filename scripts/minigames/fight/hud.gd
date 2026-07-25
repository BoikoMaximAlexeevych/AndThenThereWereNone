class_name FightHud
extends CanvasLayer

@export var bar: ProgressBar
@export var prompt: Label

func set_progress(value: float) -> void:
	bar.value = value

func set_prompt(text: String) -> void:
	prompt.text = text;
