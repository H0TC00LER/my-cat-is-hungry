extends Area3D

@export var is_final: bool = false
@export var text: Array[String]

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		if is_final:
			DialogManager.dialog_finished.connect(_on_dialog_finished)
			DialogManager.show_dialog(text)
		else:
			DialogManager.show_dialog(text)
			queue_free()
		
func _on_dialog_finished() -> void:
	EventManager.start_ending()
	queue_free()
