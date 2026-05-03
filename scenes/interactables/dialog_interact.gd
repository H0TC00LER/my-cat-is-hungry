extends Area3D

@export var text: Array[String]

func interact(player: Player) -> void:
	DialogManager.show_dialog(text)
