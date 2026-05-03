extends CanvasLayer

@onready var start: Button = $Start
@onready var exit: Button = $Exit

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/main.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
