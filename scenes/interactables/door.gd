class_name Door
extends Node3D

@export var is_door_mirror: bool = false

@onready var hinge_joint_3d: HingeJoint3D = $HingeJoint3D
var target_velocity = -hinge_joint_3d.PARAM_MOTOR_TARGET_VELOCITY

func _ready() -> void:
	if is_door_mirror:
		target_velocity = -target_velocity

func interact(player: Player) -> void:
	target_velocity = -target_velocity
	hinge_joint_3d.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY, target_velocity)
