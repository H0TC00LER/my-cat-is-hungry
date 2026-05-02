extends CanvasLayer

signal fade_finished

@onready var rect: ColorRect = $ColorRect

func fade_in() -> void:
	rect.modulate.a = 1.0
	var tween = create_tween()
	tween.tween_property(rect, "modulate:a", 0.0, 2.0)
	tween.finished.connect(func(): fade_finished.emit())

func fade_out() -> void:
	rect.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(rect, "modulate:a", 1.0, 2.0)
	tween.finished.connect(func(): fade_finished.emit())
