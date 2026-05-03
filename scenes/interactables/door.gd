class_name Door
extends Node3D

@export var is_door_mirror: bool = false

var is_opened: bool = true
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var audio_stream_player_3d_2: AudioStreamPlayer3D = $AudioStreamPlayer3D2

@onready var hinge_joint_3d: HingeJoint3D = $HingeJoint3D
var target_velocity = -hinge_joint_3d.PARAM_MOTOR_TARGET_VELOCITY

func _ready() -> void:
	if is_door_mirror:
		target_velocity = -target_velocity

func interact(player: Player) -> void:
	if is_opened:
		audio_stream_player_3d.play()
	else:
		audio_stream_player_3d_2.play()
	is_opened = not is_opened
	target_velocity = -target_velocity
	hinge_joint_3d.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY, target_velocity)
