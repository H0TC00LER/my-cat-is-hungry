extends CanvasLayer

@onready var label: Label = $MarginContainer/ColorRect/MarginContainer/Label

func _ready() -> void:
	visible = false

func show_quest(text: String) -> void:
	visible = true
	label.text = text
	
func remove_quest() -> void:
	visible = false
