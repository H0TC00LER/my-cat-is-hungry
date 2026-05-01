extends RigidBody3D

func interact(player: Player) -> void:
	get_parent().interact(player)
