class_name Safe
extends Area3D

@onready var safe_door: MeshInstance3D = $safe_door

@export var correct_code: Array[int] = [0, 5, 0, 8]

func interact(player: Player) -> void:
	SafeUi.open(self)

func try_code(code: Array[int]) -> bool:
	return code == correct_code

func open_door() -> void:
	safe_door.queue_free()
