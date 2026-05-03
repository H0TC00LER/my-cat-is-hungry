class_name Safe
extends Area3D
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D

@onready var safe_door: MeshInstance3D = $safe_door
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

var is_open: bool = false

@export var correct_code: Array[int] = [0, 5, 0, 8]

func interact(player: Player) -> void:
	audio_stream_player_3d.play()
	if not is_open:
		SafeUi.open(self)

func try_code(code: Array[int]) -> bool:
	return code == correct_code

func open_door() -> void:
	safe_door.queue_free()
	await get_tree().process_frame
	collision_shape_3d.disabled = true
	is_open = true
