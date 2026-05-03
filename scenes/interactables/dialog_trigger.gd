extends Area3D

@export var text: Array[String]

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		DialogManager.show_dialog(text)
		queue_free()
