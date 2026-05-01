class_name Door
extends Node3D

@onready var hinge_joint_3d: HingeJoint3D = $HingeJoint3D

var is_open: bool = false

func interact(player: Player) -> void:
	if not is_open:
		hinge_joint_3d.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY, 60)
	else:
		hinge_joint_3d.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY, -60)
	is_open = not is_open
